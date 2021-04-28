function [p, r, AUC] = pr_curve(score, gt)
% AUTHOR: Son La
% STUDENT NUMBER: y107227
% This function returns two arrays containing precision and recall at
% different threshold values
% INPUT:
% score: Nx1 array containing classification scores
% gt: Nx1 array of groundtruth
% OUTPUT:
% p: array containing precision values, length equal to the number of
% unique elements in score
% r: array containing recall values, length equal to the number of
% unique elements in score
% AUC: Area Under Curve
    % Prepare data
    [~,idx] = unique(score); 
    data = sortrows([score(idx) gt(idx)], 1, 'descend');    
    
    % Initialize values
    predicted = zeros(size(idx));
    p = zeros(size(idx));
    r = zeros(size(idx));
    
    for k = 1:size(idx, 1)
        predicted(k) = 1;

        p(k) = precision(predicted, data(:,2));
        r(k) = recall(predicted, data(:,2));   
    end
    
    % Calculate AUC
    AUC = trapz(r, p);
end