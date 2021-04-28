
close all;
I = imread('apple.jpeg');
J2 = laplace_pyramid(I,4);
figure(1)
imshow(I)
figure(2)
subplot(2,2,1)
imshow(J2{1});
subplot(2,2,2)
imshow(J2{2});
subplot(2,2,3)
imshow(J2{3});
subplot(2,2,4)
imshow(J2{4});
figure(3)
J2 = from_laplacian(J2);
imshow(J2)
size(J2)
size(I)