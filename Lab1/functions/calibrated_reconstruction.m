% Script: calibrated_reconstruction.m 
%
% Method: Performs a reconstruction of two calibrated cameras
%         by solving first for the essentila matrix E. From
%         E the rotation and translation is obtained and finally
%         the two cameras. 
%         The point-structure is obtained by triangulation.
%         Finally the result is stored as a VRML model 
% 

%----------------------------------------
% Initialisation
%----------------------------------------

% Parameters
image_ref = 1; % Reference view for triangulation & vrml model
am_cams = 2; % amount of cameras
name_file_images = 'names_images_teapot.txt'; % the two images 
image_name = 'teapot1.jpg'; % name of image (image_ref) for the VRML model
name_file_vrml = '../vrml/vrml_model.wrl'; % of the final VRML model
flag_synthetic_data = 1; % 0 - we work with real data; 1- we work with syntetic data

% adjustments
format compact;
format short g;

% initialise
data = [];
data_norm = [];
cams = zeros(6,4);
cams_norm = zeros(6,4);
cam_centers = zeros(4,2); 

%----------------------------------------
% Get data: synthetic & real
%----------------------------------------

% load synthetic data: 
% data_sim, cams_sim, model_sim; with  data_sim = cams_sim * model_sim;
% and K1_sim, K2_sim are the internal matrix of first and second camera 
if (flag_synthetic_data)
  load 'sphere_data.mat';
  data = data_sim;
end

% real data 
if (~flag_synthetic_data)
  % load '../data/data_teapot.mat'; 
  data = [];
  [images,image_names] = load_images_grey(name_file_images, am_cams); 
  data = click_multi_view(images, am_cams, data, 0); % for clicking and displaying data
  save '../data/data_teapot.mat' data; % for later use 
end

% Initialize & get the amount of points 
am_points = size(data,2);  
model = zeros(4,am_points); 

%----------------------------------------
% Set the internal cameras
%----------------------------------------

if (flag_synthetic_data)
  % for synthetic data
  K1 = [5 0 3; 0 4 2; 0 0 1]; % first camera 
  K2 = [7 0 1; 0 10 5; 0 0 1]; % second camera
else
  % for real data 
  K1 = [2250 0 400; 0 2250 300; 0 0 1];
  K2 = K1; 
end

%---------------------------------------------
% Get the Essential matrix & Cameras & model
%---------------------------------------------

% determine the essential matrix 
E = det_E_matrix(data(1:3,:), data(4:6,:), K1, K2);

% determine the two camera matrices
[cams, cam_centers] = det_stereo_cameras(E, K1, K2, data(:,1)); 

% obtain the complete model by triangulation
% first normalize the model and the cameras 
[norm_mat] = get_normalization_matrices(data);
data_norm(1:3,:) = norm_mat(1:3,:) * data(1:3,:);
data_norm(4:6,:) = norm_mat(4:6,:) * data(4:6,:);
cams_norm(1:3,:) = norm_mat(1:3,:) * cams(1:3,:);
cams_norm(4:6,:) = norm_mat(4:6,:) * cams(4:6,:);
model = det_model(cams_norm, data_norm);

% normalize the the 4th coordinate of model points to 1
model = norm_points_to_one(model);  

% normalize the 4th coordinate of the camera centers to 1
cam_centers = norm_points_to_one(cam_centers);    

% check the reprojection error 
[error_average, error_max] = check_reprojection_error(data, cams, model);
fprintf('\n\nThe reprojection error: data = cams * model is: \n');
fprintf('Average error: %5.2fpixel; Maximum error: %5.2fpixel \n', error_average, error_max); 

%---------------------------------------------
% Triangulation & Visualization & VRML model
%---------------------------------------------

% triangulate the result 
triang = get_delaunay_triang(data, image_ref);
% triang = [];

% visualize the reconstruction 
visualize(model, cam_centers, triang, 1); 

% save the vrml model + texture - only for real data 
if (~flag_synthetic_data)
  image_size = [size(images{1},1) size(images{1},2)];
  save_vrml(data, model, triang, name_file_vrml, image_name, image_size, 0, image_ref); 
end
