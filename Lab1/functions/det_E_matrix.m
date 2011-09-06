% function E = det_E_matrix(points1, points2, K1, K2);
%
% Method: Calculate the E matrix between two views from
%         point correspondences: points2^T * E * points1 = 0
%         we use the normalize 8-point algorithm and 
%         enforce the constraint that the three singular 
%         values are: a,a,0. The data will be normalized here. 
%         Finally we will check how good the epipolar constraints:
%         points2^T * E * points1 = 0 are fullfilled.
% 
% Input:  points1, points2 of size (3,n) 
%         K1 is the internal camera matrix of the first camera; (3,3) matrix
%         K2 is the internal camera matrix of the second camera; (3,3) matrix
% 
% Output: E (3,3) with the singular values (a,a,0) 
% 

function E = det_E_matrix(points1, points2, K1, K2)

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------
