load '../data/data_kth.mat';

data_norm = [];

NormMats = get_normalization_matrices( data );

for i = 1 : 3
  data_norm( i*3 - 2 : i*3, : ) = NormMats( i*3 - 2 : i*3, : ) * ...
                                  data( i*3 - 2 : i*3, : );
end

NormMats

data

data_norm

NormMats = get_normalization_matrices( data_norm );

NormMats
