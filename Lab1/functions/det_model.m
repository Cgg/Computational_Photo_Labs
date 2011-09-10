% function model = det_model(cam, data)
%
% Method: Determines the 3D model points by triangulation
%         of a stereo camera system. We assume that the data
%         is already normalized
%
% Input: data (6,n) matrix
%        cam (6,4) matrix
%
% Output: model (4,n matrix of all n points)
%

function model = det_model(cam, data)

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------

am_pts = size( data, 2 );

model = zeros( 4, am_points );

pa = zeros( 3, 1 );
pb = zeros( 3, 1 );

W  = zeros( 4 );

Ma = cam( 1:3, : );
Mb = cam( 4:6, : );

for i = 1 : am_pts
  pa = data( 1:3, i );
  pb = data( 4:6, i );

  for i1 = 1 : 2
    for j1 = 1 : 4
      W( i1, j1 )   = pa( i1 )*Ma( 3, j1 ) - Ma( i1, j1 );
      W( 2*i1, j1 ) = pb( i1 )*Mb( 3, j1 ) - Mb( i1, j1 );
    end
  end

  [ U, S, V ] = svd( W );

  p = V( :, size( W, 2 ) );

  model( :, i ) = p;

  W  = zeros( 4 );
end
