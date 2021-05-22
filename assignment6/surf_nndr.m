function [y1, y2] = surf_nndr(surf1, surf2, x1, x2)
% This function matches surf descriptors and returns the coordinates of the
% mutually nearest pairs sorted in decreasing similarity order. The surf
% descriptors are matched using nearest neighborhood with ratios of 
% Euclidean distances.
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
distmat = zeros(size(x1,1),size(x2,1));

standardized_surf1 = (surf1)./var(surf1, 1, 'all');
standardized_surf2 = (surf2)./var(surf2, 1, 'all');

for i = 1:size(surf1,1)
    distmat(i,:) = sqrt(sum((standardized_surf1(i,:) - standardized_surf2).^2, 2));
end

%% Find mutually nearest pairs
pairs = [];
for i = 1:size(surf1,1)
   [~, index_of_the_most_similar_descriptor_in_picture_2] = min(distmat(i,:));   
   [~, index_of_the_most_similar_descriptor_in_picture_1] = min(distmat(:,index_of_the_most_similar_descriptor_in_picture_2));
   
   if (index_of_the_most_similar_descriptor_in_picture_1 == i)
       % Find the 2nd match 
       [~, sorted_similarity_in_picture_2] = sort(distmat(i,:));
       
       % compute ratios
       distance_ratio = distmat(index_of_the_most_similar_descriptor_in_picture_1, index_of_the_most_similar_descriptor_in_picture_2) / ...
                distmat(index_of_the_most_similar_descriptor_in_picture_1, sorted_similarity_in_picture_2(2));
       
       pairs(size(pairs,1) + 1, :) = [index_of_the_most_similar_descriptor_in_picture_1, ...
           index_of_the_most_similar_descriptor_in_picture_2, ...
           distance_ratio];
   end
end

%% Sort matches
pairs = sortrows(pairs, 3);
y1 = x1(pairs(:,1), :);
y2 = x2(pairs(:,2), :);


end