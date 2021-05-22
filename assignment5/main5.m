clear all, close all, clc
%AUTHOR: Son La
%STUDENT NUMBER: y107227


%% Using your code from assignment 3, retrain the NN (using dropout) and 
% for each class (smiling/non-smiling) find a correctly and incorrectly
% classified test image. Save your trained network in the file mdl5.mat and
% the four test images you have picked. Put the saved files in the same
% folder of this script.


%% Load the trained network and read images
load('mdl5.mat')

%% For each image, plot the heat map using LIME and GRAD-CAM, you can use
% the following code skeleton as help
load('correct_image.mat')
load('false_image.mat')

figure(1)
sgtitle('LIME')
subplot(221)
% heat map 1
plot_heatmap(net2, correct_image{:,1}, "LIME");

subplot(222)
%heat map 2
plot_heatmap(net2, false_image{:,1}, "LIME");

subplot(223)
% heatmap 3
plot_heatmap(net2, false_image{:,2}, "LIME");

subplot(224)
% heatmap 4
plot_heatmap(net2, false_image{:,3}, "LIME");


figure(2)
sgtitle('GRAD-CAM')
subplot(221)
% heat map 1
plot_heatmap(net2, correct_image{:,1}, "GradCAM");

subplot(222)
%heat map 2
plot_heatmap(net2, false_image{:,1}, "GradCAM");

subplot(223)
% heatmap 3
plot_heatmap(net2, false_image{:,2}, "GradCAM");

subplot(224)
% heatmap 4
plot_heatmap(net2, false_image{:,3}, "GradCAM");

function plot_heatmap(nnet, img, alg)
    Yclassify = classify(nnet, img);
    Ypredict = predict(nnet, img);
    switch alg
        case "GradCAM"
            map = gradCAM(nnet,img, Yclassify);
        case "LIME"
            map = imageLIME(nnet,img, Yclassify, ...
                "Segmentation", "grid", ...
                "OutputUpSampling", "bicubic", ...
                "NumFeatures", 100, ...
                "NumSamples", 6000, ...
                "Model", "linear");
    end

    imshow(img, "InitialMagnification", 150)
    hold on
    imagesc(map, 'AlphaData', 0.5)
    colormap jet
    colorbar
    title(sprintf("Image %s (%s) - ", ...
        alg, Yclassify) + sprintf(" %.2f",Ypredict*100))
    hold off
end
