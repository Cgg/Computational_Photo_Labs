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

[norm_mat1] = get_normalization_matrices( points1 );
[norm_mat2] = get_normalization_matrices( points2 );

p1_norm = norm_mat1 * points1;
p2_norm = norm_mat2 * points2;

E = zeros( 3 );

% assuming points1 and points2 are paired
% assuming points1 = pointsA and points2 = pointsB

am_pts = size( p1_norm, 2 );

assert( am_pts == size( p2_norm, 2 ), 'Must provide same number of points in each set' );

e = ones( 1, 9 );

W = zeros( am_pts, 9 );

for i = 1 : am_pts
  e( 1 ) = p2_norm( 1, i ) * p1_norm( 1, i );
  e( 2 ) = p2_norm( 1, i ) * p1_norm( 2, i );
  e( 3 ) = p2_norm( 1, i );
  e( 4 ) = p2_norm( 2, i ) * p1_norm( 1, i );
  e( 5 ) = p2_norm( 2, i ) * p1_norm( 2, i );
  e( 6 ) = p2_norm( 2, i );
  e( 7 ) =                   p1_norm( 1, i );
  e( 8 ) =                   p1_norm( 2, i );

  W( i, : ) = e;
end

[ U, S, V ] = svd( W );

e = V( :, size( W, 2 ) )';

E = [ e( 1:3 ) ; e( 4:6 ) ; e( 7:9 ) ];

% generate correct E matrix -- TODO generate error ?!
%[ U, S, V ] = svd( E );

%E = zeros( 3 );

%E( 1, 1 ) = ( S( 1, 1 ) + S( 2, 2 ) ) / 2;
%E( 2, 2 ) = E( 1, 1 );

%E = U * E * V';

% get essential matrix btw non normalized points
E = norm_mat2' * E * norm_mat1;

% check that we do have the essential matrix
[ err_avg, err_max ] = checkE( E, points1, points2 );

fprintf('average error: %5.2f; maximum error: %5.2f \n', err_avg, err_max);

end
