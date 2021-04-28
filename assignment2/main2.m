clear all, close all, clc
% AUTHOR:
% STUDENT NUMBER:

%% LOAD DATA

load('data.mat')
% The file contains three arrays
% score: prediction scores obtained using fisher classifier
% gt: ground truth labels
% predicted: predicted labels using the threshold w'*(mu0+mu1)/2


p = precision(predicted, gt)
r = recall(predicted, gt)

%% PR-curve

[p, r, AUC] = sol_pr_curve(score, gt);

figure(1)
plot(r, p)
title(['AUC=', num2str(AUC)])
grid on
xlabel('recall')
ylabel('precision')