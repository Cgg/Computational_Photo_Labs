% function F = det_F_matrix(points1, points2);
%
% Method: Calculate the F matrix between two views from
%         point correspondences: points2^T * F * points1 = 0
%         we use the normalize 8-point algorithm and 
%         enforce the constraint that the last singular value is 0.
%         The data will be normalized here. 
%         Finally we will check how good the epipolar constraints:
%         points2^T * F * points1 = 0 are fullfilled.
% 
% Input:  points1, points2 of size (3,n) 
%
% Output: F (3,3) with the last singular value 0
% 

function F = det_F_matrix(points1, points2)

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------
