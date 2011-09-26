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

cams        = zeros( 6, 4 );
cam_centers = zeros( 4, 2 );

cam_centers( 4, : ) = 1; % homogeneous coordinate

[ U, S, V ] = svd( E );

% translation of camera B
T = V( :, 3 );

T = T / norm( T );

cam_centers( 1:3, 2 ) = T;


% rotation of camera B
Ma = [ K1 zeros( 3, 1 ) ];

Ra = [ 0;0;1 ];

W = [ 0 -1  0 ; ...
      1  0  0 ; ...
      0  0  1 ];

R = cell( 1, 2 );

R{1} = U * W  * V';
R{2} = U * W' * V';

for i = 1 : 2
  if( det( R{i} ) < -1e-5 )
    R{i} = - R{i};
  end
end

% the 4 possible solutions
Mb = cell( 1, 4 );

Mb{ 1 } = ( K2 * R{1} ) * [ eye( 3 ) -T ];
Mb{ 2 } = ( K2 * R{1} ) * [ eye( 3 )  T ];
Mb{ 3 } = ( K2 * R{2} ) * [ eye( 3 ) -T ];
Mb{ 4 } = ( K2 * R{2} ) * [ eye( 3 )  T ];

for i = 1 : 4
  % reconstruct 1st point of data for each possible Mb matrix
  P = det_model( [ Ma ; Mb{ i } ], data( :, 1 ) );

  % check for each point if it is in front of both cameras
  % ie dot product btw camera z axis (given by 3rd column of associated
  % rotation matrix) and vector from projection center to
  % point is 0.
  CaP = P(1:3);

  if( mod( i, 2 ) ~= 0 ) % i = 1 or 3
    CbP = P(1:3) + T; % vector from proj center of CamB to Point
  else
    CbP = P(1:3) - T;
  end

  dot( CaP, Ra )
  dot( CbP, R{ ceil( i / 2 ) }( :, 3 ) )

  if( dot( CaP, Ra ) > 1e-5 && ...
      dot( CbP, R{ ceil( i / 2 ) }( :, 3 ) ) > 1e-5 )
    fprintf( 'the solution is %i \n', i );

    break % ugly

  end
end

cams( 1:3, : ) = Ma;
cams( 4:6, : ) = Mb{ i };

% Last, we verify that E = R[t]x

if( mod( i, 2 ) ~= 0 ) % i = 1 or 3
  cam_centers( 1:3, 2 ) = T
else
  cam_centers( 1:3, 2 ) = -T
end

T = zeros( 3 );

T( 1, 2 ) =  cam_centers( 3, 2 );
T( 1, 3 ) = -cam_centers( 2, 2 );
T( 2, 3 ) =  cam_centers( 1, 2 );

if( mod( i, 2 ) ~= 0 )
  T = -T;
end

T = T - T';

T = R{ceil(i/2)}*T;

T = T/norm(T);

E = E/norm(E);


fprintf( '\nChecking that E - R.[t]x = 0 (more or less)\n' );
E-T

end
