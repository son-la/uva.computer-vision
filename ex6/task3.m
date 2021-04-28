clear all, close all, clc

I = imread('Boston1.png');
I = im2double(I);

[x, y] = harris(I);

figure;
subplot(121);
imshow(I);
hold on
plot(x, y, 'rx');
hold off
title('ours')

corners = detectHarrisFeatures(I);
points = corners.Location;
subplot(122)
imshow(I)
hold on
plot(points(:,1), points(:,2), 'rx')
hold off
title('matlab built in')