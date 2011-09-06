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
