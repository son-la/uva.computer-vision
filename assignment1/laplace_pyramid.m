function pyr = laplace_pyramid(I, levels)
% AUTHOR: Son La
% STUDENT NUMBER: y107227
%
% This function computes the laplacian pyramid of the image I.
% PARAMETERS:
% I: greyscale or rgb image as a double
% levels: number of levels in the pyramid
% OUTPUT:
% pyr: laplacian pyramid, cell array of length equal to levels
    gaussian_filtered = gauss_pyramid(I, levels);
    for i = 1:levels-1
        pyr{i} = gaussian_filtered{i} - imresize(gaussian_filtered{i+1},size(gaussian_filtered{i}, [1 2]));
    end 
    
    %The last level of the pyramid should be the same of the Gaussian pyramid.
    pyr{levels} = gaussian_filtered{levels};
end