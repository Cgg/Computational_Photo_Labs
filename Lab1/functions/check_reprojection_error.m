% function [error_average, error_max] = check_reprojection_error(data, cam, model)
%
% Method: Evaluates average and maximum error 
%         between the reprojected image points (cam*model) and the 
%         given image points (data), i.e. data = cam * model 
%
% Input:  data (3*m,n) matrix with m cameras and n points 
%         cam  (3*m,4) matrix 
%         model (4,n) matrix
%       
% Output: the average error (error_average) and maximum error (error_max)
%      

function [error_average, error_max] = check_reprojection_error(data, cam, model)

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------

test_data = cam * model;

am_pts  = size( model, 2 );

error_average = 0;
error_max     = 0;

for i = 1 : am_pts
  for j = 1 : 2
  % euclidean distance btw slice of data and slice of test_data
  error_curr = sqrt( sum( (data(j*3-2:j*3,i) - test_data(j*3-2:j*3,i) ).^2 ) );

  error_average = error_average + error_curr;

  if error_curr > error_max
    error_max = error_curr;
  end

  end
end

error_average = error_average / (2*am_pts);
