%% ASSIGNMENT: IMAGE BLENDING
% AUTHOR: Son La
% STUDENT NUMBER: y107227
clear all, close all, clc

%% Load the images and convert to double
apple = im2double(imread("apple.jpeg"));
orange = im2double(imread("orange.jpeg"));

%% TODO: Create the masks mask_orange and mask_apple
mask_orange = ones(size(orange,[1 2]));
mask_orange(:, 1:round(size(orange,2))/2,:)=0;
mask_apple = ones(size(apple,[1 2]));
mask_apple(:, round(size(apple,2)/2)+1:end,:)=0;

%% TODO: Perform simple blending
blend_simple = orange.*mask_orange + apple.*mask_apple;

%% TODO: Extract the laplace pyramids of the images
levels = 10;

apple_laplace = laplace_pyramid(apple, levels);
orange_laplace= laplace_pyramid(orange, levels);

%% Reconstruct the apple image from the laplace pyramid and check that the error is small
rec = from_laplacian(apple_laplace);
max_error=max(abs(apple(:)-rec(:)))

%% Compute the gaussian pyramids of the masks
mask_orange_gauss = gauss_pyramid(mask_orange, levels);
mask_apple_gauss = gauss_pyramid(mask_apple, levels);

%% Combine each level of the pyramids
for i = 1:levels
    blended_pyramid{i} = apple_laplace{i}.*mask_apple_gauss{i} + orange_laplace{i}.*mask_orange_gauss{i};
end
%% Reconstruct the blended image from the new pyramid
blended = from_laplacian(blended_pyramid);

%% Visualize the results
figure;
subplot(221)
imshow(apple);
title('Apple')

subplot(222)
imshow(orange)
title('Orange');

subplot(223);
imshow(blend_simple);
title('Naive blending');

subplot(224);
imshow(blended)
title('Proper blending')