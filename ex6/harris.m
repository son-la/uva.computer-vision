function [x, y] = harris(I, alph, th, sigma)
% Harris corner detector

if nargin<4 || isempty(sigma)
    sigma = 1;
end

if nargin<3 || isempty(th)
    th=0.005;
end

if nargin<2 || isempty(alph)
    alph=0.04; %relTh=0.0001; %Relative threshold
end

I = im2double(I);
if size(I, 3) > 1
    I = rgb2gray(I);
end

%% Blurring


%% compute derivatives

%% compute response function

end
