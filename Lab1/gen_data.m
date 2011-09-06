% function data = gen_data(seed, testflag)
% 
% Generates a samples from two data classes. The result is return as 
% [x1 x2 c], where x1 and x2 are the attributes of each sample, and c
% is its class, 0 or 1.
%
% seed is an optional parameter, which sets the seed for the random number
% generator. If this parameter is provided, the result will always be the
% same. seed should be your birthday in format (YYMMDD), six digits.
%
% testflag is an optional parameter, 0 or 1. If set, samples will be
% generated with under the same conditions as without the testflag, but
% each sample will be different. Use testflag = 0 to generate training
% data, and testflag = 1 to generate test data.

function d = gen_data(seed, testflag)

if (nargin > 0)
    rand('state',seed);
end

nclust = 3;

pos_source = 0.5*rand(1,2); 
pos_source = [pos_source; pos_source(1,:)+[-0.3+0.1*rand 0.5+0.1*rand]];
pos_source = [pos_source; pos_source(1,:)+[0+0.1*rand 1+0.1*rand]];

neg_source = [];
for i=1:nclust
    neg_source = [neg_source; pos_source(i,:)+[-0.4 0]];
end    

spread = 0.1*rand(nclust,2)+repmat(0.4,nclust,2);
if (nargin > 1 && testflag == 1)
    rand('state',seed);
end
pos_data = [];
neg_data = [];

for i=1:nclust
    ndata = 10+floor(10*rand);
    pos_data = [pos_data; spread(i,1)*rand(ndata,2)+repmat(pos_source(i,:), ndata,1)];
end
for i=1:nclust
    ndata = 10+floor(30*rand);
    neg_data = [neg_data; spread(i,2)*rand(ndata,2)+repmat(neg_source(i,:), ndata,1)];
end


clf
plot(pos_data(:,1), pos_data(:,2), 'o');
hold on;
plot(neg_data(:,1), neg_data(:,2), '+r');
d = [pos_data repmat(1, length(pos_data), 1); neg_data repmat(0, length(neg_data), 1)];