function dI = canny(I, thLow, thHigh)
if nargin < 2
    thLow = 0.05;
end
if nargin < 3
    thHigh = 0.1;
end

I = im2double(I); % convert to double
if size(I,3) > 1 % convert to grayscale if color image
    I = rgb2gray(I);
end

%% compute derivatives


%% non-maximum suppression


%% HYSTERESIS THRESHOLDING

end
