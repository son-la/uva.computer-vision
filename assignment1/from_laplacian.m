function img = from_laplacian(pyr)
% AUTHOR: Son La
% STUDENT NUMBER: y107227
% 
% This function reconstructs the image from a laplacian pyramid
% PARAMETERS:
% pyr: laplacian pyramid
% OUTPUT:
% img: reconstructed image from the laplace pyramid
    img = pyr{end};
    for i = size(pyr,2):-1:2
        img = pyr{i-1} + imresize(img, size(pyr{i-1}, [1 2]));
    end
end