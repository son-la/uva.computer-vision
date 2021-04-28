clear all, close all, clc

I = rgb2gray(imread('peppers.png'));
I = im2double(I);

%%


dIsobel = gradientImage(I, 'sobel', 0.1);
dIroberts = gradientImage(I, 'roberts', 0.1);
dIprewitt = gradientImage(I, 'prewitt', 0.1);
dIcanny = canny(I);

figure;
subplot(221);
imshow(dIcanny); title('canny');

subplot(222);
imshow(dIsobel); title('sobel');

subplot(223);
imshow(dIroberts); title('roberts');

subplot(224);
imshow(dIprewitt); title('prewitt');