% Input:  E, the essential matrix
%         points1, points2 of size (3,n)
%
% Check that E is really the essential matrix for points1 and points2, i.e.
% we have points2^T * E * points1 = 0.


function [ err_avg, err_max ] = checkE( E, points1, points2 )

am_pts = size( points1, 2 );

err_cur = 0;
err_max = 0;
err_avg = 0;

for i = 1 : am_pts

  err_cur = abs( points2( :, i )' * E * points1( :, i ) );

  err_avg = err_avg + err_cur;

  if err_cur > err_max
    err_max = err_cur;
  end

end

err_avg = err_avg / am_pts;

end
