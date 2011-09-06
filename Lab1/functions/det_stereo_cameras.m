% function [cams, cam_centers] = det_stereo_cameras(E, K1, K2, data); 
%
% Method: Calculate the first and second camera matrix. 
%         The second camera matrix is unique up to scale. 
%         The essential matrix and 
%         the internal camera matrices are known. Furthermore one 
%         point is needed in order solve the ambiguity in the 
%         second camera matrix.
% 
% Input:  E - essential matrix with the singular values (a,a,0) 
%         K1 - internal matrix of the first camera; (3,3) matrix
%         K2 - internal matrix of the second camera; (3,3) matrix
%         data - (6,1) matrix, of 2 points in camera one and two 
% 
% Output: cams (6,4), where cams(1:3,:) is the first and 
%                     cams(4:6,:) is the second camera      
%         cam_centers(4,2) where (:,1) is the first and (:,2) 
%                          the second camera center
%

function [cams, cam_centers] = det_stereo_cameras(E, K1, K2, data)

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------
