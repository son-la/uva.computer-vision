
I = imread('apple.jpeg');
figure(1)
J2 = laplace_pyramid(I,4);
subplot(2,2,1)
imshow(J2{1});
subplot(2,2,2)
imshow(J2{2});
subplot(2,2,3)
imshow(J2{3});
subplot(2,2,4)
imshow(J2{4});
figure(2)
J2 = sol_laplace_pyramid(I,4);
subplot(2,2,1)
imshow(J2{1});
subplot(2,2,2)
imshow(J2{2});
subplot(2,2,3)
imshow(J2{3});
subplot(2,2,4)
imshow(J2{4});
% pyr = gauss_pyramid([1,2,3,4,5;6,7,8,9,10;11,12,13,14,15], 1);