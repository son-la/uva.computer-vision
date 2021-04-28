function dI = gradientImage(I, method, th)
% AUTHOR: Son La
% STUDENT NUMBER: y107227
% Computes the magnitudes of the gradients using the given method.
% INPUT:
% I: grayscale image of doubles
% method: method to compute the partial derivatives. It is a string that
%         can assume one of the following values: sobel, roberts, prewitt.
% th: OPTIONAL, threshold parameter between 0 and 1. If it is given, then 
%     all pixels in dI which have intensity >= th*dImax are set to 1 and
%     all pixels with intensity < th*dImax are set to 0. dImax is the
%     maximum value of dI. If this parameter is not given, then dI contains
%     the magnitudes of the gradients
% OUTPUT:
% dI: grayscale image with same size of I. each pixel of dI contains the
% intensity of the gradient at the corresponding pixel in I.

% compute the gradient magnitudes here

% With some help of OpenCV material https://docs.opencv.org/3.4/d2/d2c/tutorial_sobel_derivatives.html
    switch method
        case 'sobel'
            kx = 1/8 * [-1  0 1; -2 0 2; -1 0 1];
            ky = 1/8 * [-1 -2 -1; 0 0 0; 1 2 1];
        case 'roberts'
            kx = [-1  0; 0 1];
            ky = [0 -1; 1 0];
        case 'prewitt'
            kx = [-1 0 1; -1 0 1; -1 0 1];
            ky = [-1 -1 -1; 0 0 0; 1 1 1];
        otherwise
            % throw an error
    end
    
    H = conv2(I, kx, 'same');
    V = conv2(I, ky, 'same');
    dI = sqrt(H.*H + V.*V);
    

if nargin > 2
    % do binarization with the threshold th here!
    dImax = max(dI(:))
    
    dI(find(dI >= th*dImax)) = 1;
    dI(find(dI < th*dImax)) = 0;
end

end