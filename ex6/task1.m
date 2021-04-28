clear all, close all, clc

I = rgb2gray(imread('peppers.png'));
I = im2double(I);

%%
dIsobel = gradientImage(I, 'sobel');
dIroberts = gradientImage(I, 'roberts');
dIprewitt = gradientImage(I, 'prewitt');

figure(1);
subplot(221);
imshow(I); title('original');

subplot(222);
imshow(dIsobel); title('sobel');

subplot(223);
imshow(dIroberts); title('roberts');

subplot(224);
imshow(dIprewitt); title('prewitt');

%%
dIsobel = gradientImage(I, 'sobel', 0.1);
dIroberts = gradientImage(I, 'roberts', 0.1);
dIprewitt = gradientImage(I, 'prewitt', 0.1);

figure(2);
subplot(221);
imshow(I); title('original');

subplot(222);
imshow(dIsobel); title('sobel');

subplot(223);
imshow(dIroberts); title('roberts');

subplot(224);
imshow(dIprewitt); title('prewitt');