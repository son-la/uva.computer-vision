function ssd = get_ssd(X, kmax)
%AUTHOR: Son La
%STUDENT NUMBER: y107227
% This function performs k-means clustering for k=1:kmax and stores the
% SSD value for each k into the array ssd
% INPUT
% X: NxD matrix, data points, each row is a point in D-dimensional space
% kmax: maximum number of clusters
% OUTPUT
% ssd: array of length kmax containing the SSD values

ssd = zeros(kmax,1);
for k = 1:kmax
    [labels, C, cnt] = k_means_cluster(X, k);
    figure(k)
    L = reshape(labels, [384   512]);
    J = label2rgb(L, C);
    imshow(J)
    for i = 1:size(X,1)
        ssd(k) = ssd(k) + sum((X(i, :) - C(labels(i), :)).^2, 'all');
    end
end

end
