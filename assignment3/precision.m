function p = precision(predicted, gt)
%AUTHOR: Son La
%STUDENT NUMBER: y107227
% This function computes the precision of a classifier
% INPUT
% predicted: Nx1 binary array of predicted labels
% gt: Nx1 binary array of gt
% OUTPUT
% p: precision value

TP = sum(predicted & gt); % Predicted = 1 & GT = 1
FP = sum(predicted & ~gt); % Predicted = 1 & GT = 0 
p = TP/(TP + FP);

end