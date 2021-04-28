function pyr = gauss_pyramid(I, levels)
% AUTHOR: Son La
% STUDENT NUMBER: y107227
%
% This function computes the gaussian pyramid of the image I.
% PARAMETERS:
% I: greyscale or rgb image as a double
% levels: number of levels in the pyramid
% OUTPUT:
% pyr: gaussian pyramid, cell array of length equal to levels
    pyr{1} = I;
    kernel_width = 3;
    sigma = 2;
    for i = 2:levels
        pyr{i} = imresize(imfilter(pyr{i-1}, fspecial('gaussian',[kernel_width kernel_width], sigma), 'symmetric', 'same'), 1/2);
    end    
end