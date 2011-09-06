% Script: uncalibrated_reconstruction.m 
%
% Method: Performs a reconstruction of two 
%         uncalibrated cameras. The Fundametal matrix determines 
%         uniquely both cameras. The point-structure is obtained 
%         by triangulation. The projective reconstruction is 
%         rectified to a metric reconstruction with knowledge 
%         about the 3D object.
%         Finally the result is stored as a VRML model 
% 

%----------------------------------------
% Initialisation
%----------------------------------------

% Parameters
image_ref = 1; % Reference view
am_cams = 2; % amount of cameras
name_file_images = 'names_images_toyhouse.txt';
image_name = 'toyhouse1.jpg'; 
name_file_vrml = '../vrml/vrml_model.wrl';
flag_synthetic_data = 0; % 0 - we work with real data; 1- we work with syntetic data

% adjustments
format compact;
format short g;

% initialise
data = [];
data_norm = [];
cams = zeros(6,4);
cams_norm = zeros(6,4);
cam_centers = zeros(4,2); 
model_synthetic = [];  

%----------------------------------------
% Get data: synthetic & real
%----------------------------------------

% load synthetic data: 
% data_sim, cam_sim, model_sim; with  data_sim = cam_sim * model_sim;
if (flag_synthetic_data)
  load 'sphere_data.mat';
  data = data_sim;
end

% real data 
if (~flag_synthetic_data)
  % load '../data/data_toyhouse.mat';
  data = [];
  [images,image_names] = load_images_grey(name_file_images, am_cams);
  data = click_multi_view(images, am_cams, data, 2); % for clicking and displaying data
  save '../data/toyhouse_data.mat' data;
end

%-----------------------------------------------
% Get the Fundamental matrix & Cameras & model
%-----------------------------------------------

% determine the Fundamental matrix 
F = det_F_matrix(data(1:3,:), data(4:6,:));

% get the projective reconstruction 
[cams, cam_centers] = det_uncalib_stereo_cameras(F); 

% obtain the complete model by triangulation
% first normalize the model and the cameras 
[norm_mat] = get_normalization_matrices(data);
data_norm(1:3,:) = norm_mat(1:3,:) * data(1:3,:);
data_norm(4:6,:) = norm_mat(4:6,:) * data(4:6,:);
cams_norm(1:3,:) = norm_mat(1:3,:) * cams(1:3,:);
cams_norm(4:6,:) = norm_mat(4:6,:) * cams(4:6,:);
model = det_model(cams_norm, data_norm);

% check the reprojection error 
[error_average, error_max] = check_reprojection_error(data, cams, model);
fprintf('\n\nThe reprojection error: data = cams * model is: \n');
fprintf('Average error: %5.2fpixel; Maximum error: %5.2fpixel \n', error_average, error_max); 

%-----------------------------------------------------
% Rectify the reconstruction: cameras and 3D model
%-----------------------------------------------------

if (flag_synthetic_data)
  model_synthetic_points = [1,13,25,37,48];
  model_synthetic = [];  
  for hi1 = 1:5
    hd1 = model_synthetic_points(1,hi1); 
    model_synthetic = [model_synthetic,model_sim(:,model_synthetic_points(1,hi1))];
  end
else 

  %------------------------------
  %
  % FILL IN THIS PART 
  %
  %------------------------------

end

% get the rectification matrix 
H = det_rectification_matrix(model(:,model_synthetic_points), model_synthetic); 
% H = eye(4); 

% rectify the cameras and the model

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------

% normalize the the 4th coordinate of model points is 1
[model_rec] = norm_points_to_one(model_rec);  
 
% normalize the 4th coordinate of the camera centers
[cam_centers_rec] = norm_points_to_one(cam_centers_rec);    


%---------------------------------------------
% Triangulation & Visualization & VRML model
%---------------------------------------------

triang = get_delaunay_triang(data, image_ref);
% triang = [];

% visualize the reconstruction 
visualize(model_rec, cam_centers_rec, triang, 1); 

% save the vrml model + texture
if (~flag_synthetic_data)
  image_size = [size(images{1},1) size(images{1},2)];
  save_vrml(data, model_rec, triang, name_file_vrml, image_name, image_size, 0, image_ref); 
end
