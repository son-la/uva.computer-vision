%% HYBRID IMAGES

clear all, close all, clc
%% Load test images.
man=double(imread('man.jpg'));
wolf=double(imread('wolf.jpg'));

% the pixel coordinates of eyes and chin have been manually found 
% from both images in order to enable affine alignment 
man_eyes_chin =[400 492; 631 492;508 884];
wolf_eyes_chin=[851 919; 1159 947; 975 1451];
%% Images alignment, you will learn about this in a few weeks. For now, 
% you can just run this section

[A,b]=affinefit(man_eyes_chin', wolf_eyes_chin');

[X,Y]=meshgrid(1:size(man,2), 1:size(man,1));
pt=A*([X(:) Y(:)]')+b*ones(1,size(man,1)*size(man,2));
wolft=interp2(wolf,reshape(pt(1,:),size(man)),reshape(pt(2,:),size(man)));

%% TODO: Simply blend the aligned images using additive superimposition
additive_superimposition = 

%% TODO: gaussian filters. Using the matlab function fspecial, create two
% gaussian lowpass filters with given standard deviation. The kernel size
% should be 4sigma+1
sigmaA = 15; 
sigmaB = 10;
filterA = 
filterB = 

%% TODO: Apply the lowpass filters to the images.
% Use filterA for man and filterB for wolft
% HINT: matlab function imfilter. Use the 'replicate' padding option.

man_lowpass = 
wolft_lowpass = 

%% TODO: Get the high-pass filtered image of the wolf
%
% HINT: You get a high-pass version by subtracting the low-pass filtered version
% from the original image.

wolft_highpass = 

%% TODO: combine the filtered images into one hybrid image
hybrid_image = 

%% Visualization and interpretation
% Notice how strongly the interpretation of the hybrid image is affected 
% by the viewing distance
fighybrid=figure;colormap('gray');imagesc((hybrid_image));axis image;
%
% Display input images and both output images.
figure; clf;
set(gcf,'Name','Results of superimposition');

subplot(2,2,1); imagesc(man);
axis image; colormap gray;
title('Input Image A');

subplot(2,2,2); imagesc(wolf);
axis image; colormap gray;
title('Input Image B');

subplot(2,2,3); imagesc(additive_superimposition);
axis image; colormap gray;
title('Additive Superimposition');

subplot(2,2,4); imagesc(hybrid_image);
axis image; colormap gray;
title('Hybrid Image');


figure(fighybrid);

%% Study fft

F_man = fftshift(fft2(man));
F_wolft = fftshift(fft2(wolft));
F_man_lowpass = fftshift(fft2(man_lowpass));
F_wolft_highpass = fftshift(fft2(wolft_highpass));

figure; clf;
set(gcf,'Name','Magnitudes of the Fourier transforms');

subplot(2,2,1);
imshow(log(abs(F_man)),[]);
title('log(abs(F-man))');

subplot(2,2,2); 
imshow(log(abs(F_man_lowpass)),[]);
title('log(abs(F-man-lowpass))');


subplot(2,2,3); 
imshow(log(abs(F_wolft)),[]);
title('log(abs(F-wolft))');

subplot(2,2,4); 
imshow(log(abs(F_wolft_highpass)),[]);
title('log(abs(F-wolft-highpass))');