%% ASSIGNMENT 3
% AUTHOR: Son La
% STUDENT NUMBER: y1072227
clear all, close all, clc

% NOTE: YOU MUST HAVE UNTARRED THE DATASET BEFORE RUNNING THIS CELL
% read labels
fid = fopen('labels.txt', 'r');
labels = fscanf(fid, '%d %f %f %f\n');
fclose(fid);
labels = labels(1:4:end) > 0;

% create image datastore
imds = imageDatastore('files');
imds.Labels = categorical(labels);
montage(imds.Files([1:5, end-4:end]));

% split into training and test data
numTrainFiles = 0.8;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

%% TODO: convert imdsTrain and imdsTest to augmented image datastores, to ensure all pictures have the correct size (64x64) and are rgb

imdsTrain = augmentedImageDatastore([64 64], imdsTrain, 'ColorPreprocessing', 'gray2rgb');
imdsValidation = augmentedImageDatastore([64 64], imdsValidation, 'ColorPreprocessing', 'gray2rgb')

%% TODO CREATE YOUR NETWORK
imageSize = [64 64 3];
layers = [
    imageInputLayer(imageSize)
    
    convolution2dLayer(5,32,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5,32,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    fullyConnectedLayer(128)
    reluLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    
    classificationLayer];

%% TRAINING OPTINS
options = trainingOptions('sgdm', ...
    'MaxEpochs',40, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'ExecutionEnvironment','parallel', ...
    'Verbose',false, ...
    'Plots','training-progress');


%% TODO: TRAIN YOUR NETWORK
net1 = trainNetwork(imdsTrain,layers,options);

%% TODO: EVALUATE YOUR NETWORK ON THE VALIDATION DATA

% extracting groundtruth labels, a little clumsy for augmented image
% datastores, so I'll do it for you :)
data = readall(imdsValidation);
YValidation = data.response;
YPredicted = predict(net1, data);


%% TODO PLOT PR-CURVE
[p, r, AUC] = pr_curve(YPredicted(:,2), YValidation == 'true')
figure(1)
plot(r, p)
title(['AUC=', num2str(AUC)])
grid on
xlabel('recall')
ylabel('precision')

%% TODO ADD DROPOUT LAYER
% you can either modify the parts above or copy

layers = [
    imageInputLayer(imageSize)
    
    convolution2dLayer(5,32,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5,32,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    fullyConnectedLayer(128)
    reluLayer
    
    dropoutLayer(0.5)
    
    fullyConnectedLayer(2)
    softmaxLayer
    
    classificationLayer];

options = trainingOptions('sgdm', ...
    'MaxEpochs',40, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'ExecutionEnvironment','parallel', ...
    'Verbose',false, ...
    'Plots','training-progress');

net2 = trainNetwork(imdsTrain,layers,options);

data = readall(imdsValidation);
YValidation = data.response;
YPredicted = predict(net2, data);

[p, r, AUC] = pr_curve(YPredicted(:,2), YValidation == 'true')
figure(2)
plot(r, p)
title(['AUC=', num2str(AUC)])
grid on
xlabel('recall')
ylabel('precision')
