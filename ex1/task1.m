clear all, close all, clc

%% GRAYSCALE IMAGE EXAMPLE
I = im2double(imread('einsteinpic.jpg'));

% add noise
I = imnoise(I, 'salt & pepper',0.1);

K = 5;
J = median_filter(I, K);

figure;
subplot(121)
imshow(I);
title('noisy');

subplot(122);
imshow(J);
title('denoised');

%% COLOR IMAGE EXAMPLE

I = im2double(imread('peppers.png'));

% add noise
I = imnoise(I, 'salt & pepper',0.1);

K = 5;
J = median_filter(I, K);

figure;
subplot(121)
imshow(I);
title('noisy');

subplot(122);
imshow(J);
title('denoised');