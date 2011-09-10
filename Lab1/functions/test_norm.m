load 'sphere_data.mat';
data = data_sim( 4:6, : );

data_norm = [];

NormMats = get_normalization_matrices( data );

for i = 1 : 1
  data_norm( i*3 - 2 : i*3, : ) = NormMats( i*3 - 2 : i*3, : ) * ...
                                  data( i*3 - 2 : i*3, : );
end

NormMats

data

data_norm

NormMats = get_normalization_matrices( data_norm );

NormMats
