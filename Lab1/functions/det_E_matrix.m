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

E = zeros( 3 );

% assuming points1 and points2 are paired
% assuming points1 = pointsA and points2 = pointsB

am_pts = size( points1, 2 );

assert( am_pts == size( points2, 2 ), 'Must provide same number of points in each set' );

e = ones( 1, 9 );

W = zeros( am_pts, 9 );

for i = 1 : am_pts
  e( 1 ) = points2( 1 ) * points1( 1 );
  e( 2 ) = points2( 1 ) * points1( 2 );
  e( 3 ) = points2( 1 );
  e( 4 ) = points2( 2 ) * points1( 1 );
  e( 5 ) = points2( 2 ) * points1( 2 );
  e( 6 ) = points2( 2 );
  e( 7 ) =                points1( 1 );
  e( 8 ) =                points1( 2 );

  W( i, : ) = e;
end

[ U, S, V ] = svd( W );

e = V( :, size( W, 2 ) )';

E = [ e( 1:3 ) ; e( 4:6 ) ; e( 7:9 ) ];

end
