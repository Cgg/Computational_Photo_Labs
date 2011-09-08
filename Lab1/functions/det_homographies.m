% H = det_homographies(points1, points2)
%
% Method: Determines the mapping H * points1 = points2
% 
% Input:  points1, points2 are of the form (3,n) with 
%         n is the amount of points 
%         The points should be normalized for 
%         better performance 
% 
% Output: H (3,3) matrix 
%

function H = det_homographies(points1, points2)

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------

% Algorithm
% foreach corresponding points i 
%  compute alphai, betai
%  stuff them at the end of AI, BI
% endfor
%
% compute Q = assemblage de AI et BI
%
% we are looking for h so that Qh = 0
%
% apply a SVD to Q (svd(Q)) and get the solution
%
% put h into the 3x3 matrix H and return it
