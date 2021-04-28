function J = median_filter(I, K)
% AUTHOR: Son La
% STUDENT NUMBER: y107227
% 
% Apply median filter to image I using a window of size KxK
% I can be either grayscale or color image. K is assumed to be odd.
% PARAMETERS:
% I: greyscale or rgb image
% K: size of the neighbourhood window. Must be odd
% OUTPUT:
% J: filtered image, same size of I

    % Prepare padded Matrix
    padding = (K-1)/2;
    paddedMatrixSize = size(I);
    paddedMatrixSize(1:2) = paddedMatrixSize(1:2) + K-1; % Minus 1 as K is odd   
    
    paddedMatrix = nan(paddedMatrixSize);
    paddedMatrix(padding+1:end-padding, padding+1:end-padding,:) = I; % Plus 1 as Matlab base index is 1
    J = paddedMatrix;
    
    % Apply median for each mini-matrix
    for i = padding+1:size(paddedMatrix,1)-padding
        for j = padding+1:size(paddedMatrix,2)-padding
            for k = 1:size(paddedMatrix,3)
                J(i,j,k) = median(paddedMatrix(i-padding:i+padding,j-padding:j+padding,k),'all','omitnan');
            end
        end
    end
    
    % Remove padding from padded Matrix
    J = J(padding+1:end-padding,padding+1:end-padding,:);
end

