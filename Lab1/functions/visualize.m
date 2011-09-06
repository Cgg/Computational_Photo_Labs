% visualize(model, cam_centers, triang, version); 
%
% Method: Vizualize the model and cameras
% 
% Input: model (4,n) the fourth coordinate has to be 1 ! (n points)
%        cam_center (3,m);  (m is amount of cameras)
%        triang is a list m,3 of m triangles. This can be []
%        version:   0: only model
%                   1: model and cam_c
%                   -1: only patches
%  
% Functionality (for view3d): 
%        left mouse: XY-rotation (R-Mode); zoom (Z-Mode)
%        middle mouse (Z-rotation) (R-Mode); pan (Z-Mode)
%        Key 'r': change to R(Rotation)-Mode
%        Key 'z': change to Z(Zoom)-Mode 
%

function visualize(model, cam_centers, triang, version)


% show functionality
disp('  '); 
disp('************* Functionality ***************');
disp('  '); 
disp('    left mouse: XY-rotation (R-Mode); zoom (Z-Mode)');
disp('    middle mouse (Z-rotation) (R-Mode); pan (Z-Mode)');
disp('    Key r: change to R(Rotation)-Mode');
disp('    Key z: change to Z(Zoom)-Mode ');

% Info
am_points = size(model,2);
am_cams = size(cam_centers,2);

% create one figure and clear it and hold it 
figure(3); 
clf; 
hold on;

% draw model
if (version >= 0) 
  for hi1 = 1:am_points
    p = plot3(model(1,hi1), model(2,hi1), model(3,hi1), '.');
    set(p,'MarkerSize', 15);
    set(p,'Color', [0 0 0]);
  end
end

% draw the trianglues 
if (version >= -1) 
  trisurf(triang,model(1,:),model(2,:),model(3,:), ones(am_points,1)); 
end

% read in the cameras
if (version > 0) 
  for hi1 = 1:am_cams
    p2 = plot3(cam_centers(1,hi1), cam_centers(2,hi1), cam_centers(3,hi1), 'x');
    set(p2,'MarkerSize', 15);
    set(p2,'Color', [1 0 0]);
  end 
end

% same axis & axis eqaul 
axis equal
if (version > -1) 
  axis on
else
  axis off
end

% do a grid
grid on

% draw it now 
drawnow

% load a good 3dviewer
view3d rot


