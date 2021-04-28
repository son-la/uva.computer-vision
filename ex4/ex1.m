clear all, close all, clc

img = rgb2gray(imread("img.jpg"));
I = double(img);

t = otsu_thresholding(I);

J = zeros(size(I));

J(I>=t) = 1;

figure(1);
subplot(1,2,1)
imshow(img)
subplot(1,2,2)
imshow(J);

p = hist(I(:), 0:255);

figure(2)

plot(0:255, p);
xline(t, 'r--', 'LineWidth', 2);

%%
I = double(rgb2gray(imread("peppers.png")));

t = otsu_thresholding(I);

J = zeros(size(I));

J(I>=t) = 1;

figure(1);
imshow(J);

p = hist(I(:), 0:255);

figure(2)
plot(0:255, p);
xline(t, 'r--', 'LineWidth', 2);