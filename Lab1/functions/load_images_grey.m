% function [images, image_names] = load_images_grey(name, am_cams)
%
% Method: load all the images specified in file name
%         and returns a cell of images in double format 
% 
%
% Input: the name of a file which consits of all images 
%        am_cams - the amount of cameras (m)
%
% Output: cell of images in double format. images{i} is image i. 
%         
%

function [images, image_names] = load_images_grey(name, am_cams)

% initialisation
images = cell(am_cams,1);
image_names = cell(am_cams,1);

fid=fopen(name);
for hi1 = 1:am_cams
  image_names{hi1} = fscanf(fid,'%s',1);
  image = imread(image_names{hi1}); % decides the format itself 
  images{hi1} = double(image)';
end
