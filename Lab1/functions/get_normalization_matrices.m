% function [norm_mat] = get_normalization_matrix(data);
%
% Method: get all normalization matrices.
%         It is: point_norm = norm_matrix * point. The norm_points
%         have centroid 0 and average distance = sqrt(2))
% 
% Input: data (3*m,n) (not normalized) the data may have NaN values
%        for m cameras and n points 
%
% Output: norm_mat is a 3*m,3 matrix, which consists of all
%         normalization matrices matrices, i.e. norm_mat(1:3,:) is the
%         matrix for camera 1
%

function [norm_mat] = get_normalization_matrices(data)


% get Info
am_cams = size(data,1)/3;
am_points = size(data,2);

%------------------------------
%
% FILL IN THIS PART
%
%------------------------------

% Algo
% for each camera do
%  calculate distance
%  calculate centroid
%  calculate N
%  put N in norm_mat

N = eye( 3 );

centroid = zeros( 3, 1 );
distance = 0;

sq2dist  = 0;

n_points = 0;

for i = 1 : am_cams

  % centroid
  for p = 1 : am_points

    if isnan( data( i*3 - 2, p ) ) == false
      centroid = centroid + data( i*3 - 2 : i*3, p );

      % increase number of points taken into account
      n_points = n_points + 1;
    end
  end

  centroid = centroid / n_points;

  % distance
  for p = 1 : am_points

    if isnan( data( i*3 - 2, p ) ) == false
      distance = distance + sqrt( sum( ( data( i*3 - 2 : i*3, p ) - ...
      centroid ).^2 ) );
      % do not need to calculate n_points, already done
    end
  end

  distance = distance / n_points;

  n_points = 0;

  % now compute N
  sq2dist = sqrt( 2 ) / distance;

  N( 1, 1 ) = sq2dist;
  N( 2, 2 ) = sq2dist;

  N( 1, 3 ) = - centroid( 1 ) * sq2dist;
  N( 2, 3 ) = - centroid( 2 ) * sq2dist;

  norm_mat( i*3 - 2 : i*3, : ) = N;
end
