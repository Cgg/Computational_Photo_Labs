% [model_norm] = norm_points_to_one(model); 
%
% Method: normalize the last coordinate (third or fourth) to one.
%         We check additional that the last coordinate bigger than eps. 
% 
% Input: model (4,n) or (3,n) 
% 
% Output: model (4,n) or (3,n) (normalized)

function [model_norm] = norm_points_to_one(model); 

% Info 
am_points = size(model,2);
dim = size(model,1);  

% Initialize
model_norm = zeros(dim,am_points); 

for hi1 = 1:am_points
  if (dim == 3) 
    if ( abs(model(3,hi1)) > eps)
      model_norm(1:3,hi1) = model(1:3,hi1) / model(3,hi1); 
    else
      warning('A model point is at infity - we leave it !');
      model_norm(:,hi1) = model(:,hi1); 
    end
  elseif (dim == 4)
    if ( abs(model(4,hi1)) > eps)
      model_norm(1:4,hi1) = model(1:4,hi1) / model(4,hi1);
    else
      warning('A model point is at infity - we leave it !');
      model_norm(:,hi1) = model(:,hi1); 
    end
  else
    error('Sorry but the dim of the data has to be 3 or 4');
  end
end
