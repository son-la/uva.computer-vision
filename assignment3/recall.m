function r = recall(predicted, gt)
%AUTHOR: Son La
%STUDENT NUMBER: y107227
% This function computes the recall of a classifier
% INPUT
% predicted: Nx1 binary array of predicted labels
% gt: Nx1 binary array of gt
% OUTPUT
% r: recall value

TP = sum(predicted & gt); % Predicted = 1 & GT = 1
FN = sum(~predicted & gt); % Predicted = 0 & GT = 1 
r = TP/(TP + FN);

end