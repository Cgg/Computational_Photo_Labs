% H = det_homographies(points1, points2)
%
% Method: Determines the mapping H * points1 = points2
%
% points1 == pb
% points2 == pa
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
%  complete Q
% endfor
%
% we are looking for h so that Qh = 0
%
% apply a SVD to Q (svd(Q)) and get the solution
%
% put h into the 3x3 matrix H and return it

am_pts = size( points1, 2 );

assert( am_pts == size( points2, 2 ), 'Must provide same number of points in each set' );

Q     = zeros( 2*am_pts, 9 );
alpha = zeros( 1, 9 );
beta  = zeros( 1, 9 );

for j = 1:am_pts
  alpha( 1:3 ) =   points1( :, j )';
  alpha( 7 )   = - points1( 1, j ) * points2( 1, j ); % - xb * xa
  alpha( 8 )   = - points1( 2, j ) * points2( 1, j ); % - yb * xa
  alpha( 9 )   = - points2( 1, j ) ;                  % - xa

  beta( 4:6 ) =   points1( :, j )';
  beta( 7 )   = - points1( 1, j ) * points2( 2, j ); % - xb * ya
  beta( 8 )   = - points1( 2, j ) * points2( 2, j ); % - yb * ya
  beta( 9 )   = - points2( 2, j ) ;                  % - ya

  Q( j, : )          = alpha( : );
  Q( j + am_pts, : ) = beta( : );
end

[ U, S, V ] = svd( Q );

h = V( :, size( Q, 2 ) )';

H = [ h( 1:3 ) ; h( 4:6 ) ; h( 7:9 ) ];

end
