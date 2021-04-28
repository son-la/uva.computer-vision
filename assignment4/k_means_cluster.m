function [labels, C, cnt] = k_means_cluster(X, k, max_iter)
% AUTHOR:
% STUDENT NUMBER:
% Thi function performs k-means clustering on data in X using k clusters
% INPUT
% X: NxD matrix. Each row is a point of a D-dimensional vector space, N
%    points in total
% k: number of clusters (positive integer)
% max_iter: (optional) maximum number of iterations
%
% OUTPUT
% labels: Nx1 column vector, containing values in the range 1:k. Each
%         element tells the cluster of the corresponding row in X, e.g. if
%         labels(i)==3 then X(i,:) belongs to the third cluster
%
% C: kxD matrix containing the centroids of the clusters, one per row.
%    For example C(1,:) corresponds to the centroid of the first cluster
%
% cnt: number of iterations done (can be useful for debugging)

    if nargin < 3
        max_iter = 500; % use maximum 500 iterations by defaults
    end

    labels = ones(size(X,1),1);

    % Pick k random points from X 
    prev_C = X(randsample(size(X,1),k), :) .* 2; % Just to make it difference
    C = X(randsample(size(X,1),k), :);
    cnt = 0;

    while (areCentroidsDifferent(C, prev_C) && cnt < max_iter)
        cnt = cnt + 1;
        prev_C = C;

        % Calculate distances from each point in X to each initial centroid
        for i = 1:size(X,1)
     
            % Find cluster where each point in X belongs to
            cluster_index = 1;
            min_distance = realmax;
            for centroid_index = 1:k
                distance = distance_calculation(C(centroid_index,:), X(i, :));
                
                if distance < min_distance
                    % Update cluster_index when finding a better centroid 
                    min_distance = distance;
                    cluster_index = centroid_index;
                end
            end
            
            labels(i) = cluster_index;
        end
        
        % Update new centroids
        for cluster_index = 1:k
            C(cluster_index, :) = centroid_update(X, X(find(labels == cluster_index), :));
        end
    end
end

function distance = distance_calculation(a,b)
    distance = sqrt(sum(abs(a - b).^2));
end

function centroid = centroid_update(X, cluster_members)
    if size(cluster_members, 1) ~= 0
        centroid = sum(cluster_members)./size(cluster_members, 1);
    else
        % Get a new point as this centroid does not attract any member
        centroid = X(randsample(size(X,1), 1));
    end
end

function output = areCentroidsDifferent(centroid1, centroid2)
    output = true;
    if size(centroid1) == size(centroid2)
        if (sum((centroid1-centroid2).^2, 'all') == 0)
            output = false;
        end
    end  
end