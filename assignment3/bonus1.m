%% Bonus1
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

% split into training and test data
numTrainFiles = 0.8;
imds = transform(imds,@transformFcn)
imds = imds.UnderlyingDatastores{1}
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

%% TODO: convert imdsTrain and imdsTest to augmented image datastores, to ensure all pictures have the correct size (64x64) and are rgb

imdsTrain = augmentedImageDatastore([64 64], imdsTrain, 'ColorPreprocessing', 'gray2rgb');
% imdsTrain = transform(imdsTrain,@transformFcn)
imdsValidation = augmentedImageDatastore([64 64], imdsValidation, 'ColorPreprocessing', 'gray2rgb')
% imdsValidation = transform(imdsValidation,@transformFcn)

%% TODO CREATE YOUR NETWORK
imageSize = [64 64 3];
numFilters = 32;
numClasses = 2;
layers = [
    imageInputLayer(imageSize)

   convolution2dLayer(5,numFilters,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5,numFilters,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    fullyConnectedLayer(128)
    reluLayer
    
    dropoutLayer(0.5)
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer
    
    ];

%% TRAINING OPTINS
options = trainingOptions('sgdm', ...
    'MaxEpochs',40, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'ExecutionEnvironment','gpu', ...
    'Verbose',false, ...
    'Plots','training-progress');


%% TODO: TRAIN YOUR NETWORK
net = trainNetwork(imdsTrain,layers,options);

%% TODO: EVALUATE YOUR NETWORK ON THE VALIDATION DATA

% extracting groundtruth labels, a little clumsy for augmented image
% datastores, so I'll do it for you :)
data = readall(imdsValidation);
YValidation = data.response;
YPredicted = predict(net, data);


%% TODO PLOT PR-CURVE
[p, r, AUC] = pr_curve(YPredicted(:,2), YValidation == 'true');
figure(1)
plot(r, p)
title(['AUC=', num2str(AUC)])
grid on
xlabel('recall')
ylabel('precision')

function outputImage = transformFcn(inputImage)
    % Enhancing contrast https://se.mathworks.com/help/images/contrast-enhancement-techniques.html
    input_histeq = rgb2lab(inputImage);
    max_luminosity = 100;
    L = input_histeq(:,:,1)/max_luminosity;
    input_histeq(:,:,1) = histeq(L)*max_luminosity;
    outputImage = lab2rgb(input_histeq);
    
end

