% triang = get_delaunay_triang(data, num_ref);
%
% Method: Gives back a delaunay triangulation in 
%         the reference view: num_ref. The MATLAB 
%         function "delaunay" is used.
%
% Input:  data (3*m,n) matrix
%
% Output: triang (amount triangles,3) a list of all triangles.
%                 Every entry is an index to the data.
%
 
function [triang] = get_delaunay_triang(data, num_ref)

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------

% We should have 1 < num_ref <= am_cam

am_cam = size( data, 2 ) / 3;

assert( (1 <= num_ref) && ( num_ref <= am_cam), ...
        'Wrong value for num_ref' );


P = data( num_ref*3 - 2 : num_ref*3 - 1 , : )';

triang = delaunay( P );