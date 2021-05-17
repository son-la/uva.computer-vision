function [y1, y2] = surf_nn(surf1, surf2, x1, x2)
% This function matches surf descriptors and returns the coordinates of the
% mutually nearest pairs sorted in decreasing similarity order. The surf
% descriptors are matched using nearest neighborhood with Euclidean
% distance.
% INPUT
% surf1: each row is a surf descriptor in the first picture.
% surf2: each row is a surf descriptor in the second picture.
% x1:    array of size mx2, each row contains the coordinates of the
%        corresponding surf descriptor in surf1.
% x3:    array of size nx2, each row contains the coordinates of the
%        corresponding surf descriptor in surf2.
% OUTPUT:
% y1, y2: arrays with same number of rows and 2 columns. Corresponding rows
%         contain the coordinates of mutually nearest surf descriptors.



%% Compute distance matrix


%% Find mutually nearest pairs


%% Sort matches


end