function g = get_gaussian(sigma, r)
% This function returns a gaussian with standard deviation sigma and radius
% r, i.e. the kernel size will be 2*r+1
% if r is not given, then it will be ceil(3*sigma);
% is sigma is not given then sigma=0.5

if nargin < 1
    sigma = 0.5;
end

if nargin < 2
    r = ceil(3*sigma);
end

[xx, yy] = meshgrid(-r:r);

g = exp(-1/(2*sigma^2)*(xx.^2+yy.^2));
g = g/sum(g(:));
end