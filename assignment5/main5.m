clear all, close all, clc
%AUTHOR:
%STUDENT NUMBER:


%% Using your code from assignment 3, retrain the NN (using dropout) and 
% for each class (smiling/non-smiling) find a correctly and incorrectly
% classified test image. Save your trained network in the file mdl5.mat and
% the four test images you have picked. Put the saved files in the same
% folder of this script.


%% Load the trained network and read images
load('mdl5.mat')


%% For each image, plot the heat map using LIME and GRAD-CAM, you can use
% the following code skeleton as help

figure(1)
sgtitle('LIME')
subplot(221)
% heat map 1

subplot(222)
%heat map 2

subplot(223)
% heatmap 3

subplot(224)
% heatmap 4

figure(2)
sgtitle('GRAD-CAM')
subplot(221)
% heat map 1

subplot(222)
%heat map 2

subplot(223)
% heatmap 3

subplot(224)
% heatmap 4

