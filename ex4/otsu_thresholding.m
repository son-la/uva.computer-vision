function tmin = otsu_thresholding(I)
% AUTHOR: Son La
% STUDENT NUMBER: y107227
% This function computes Otsu threshold
% I : grayscale image with intensities in range 0-255
% tmin: threshold computed with Otsu method

    intensity = min(I(:), 'all')+1 : max(I(:)); % To avoid empty list
    intra_class_variances = arrayfun(@(x) otsu_alg(I, x), intensity);
    [~, tmin_idx] = min(intra_class_variances);
    tmin = intensity(tmin_idx); % Corresponding index for intensity/ threshold value
    
end

function intra_class_variance = otsu_alg(I, threshold)
    classified_I = zeros(size(I));
    classified_I(find(I >= threshold)) = 1;
    
    number_of_class_1_pixels = sum(classified_I, 'all');
    total_pixels = prod(size(I));
    
    w1 = number_of_class_1_pixels / total_pixels;
    w0 = 1 - w1; % Sum of the probabilities of all outcomes equals 1
    
    var1 = var(I(find(I >= threshold)));    
    var0 = var(I(find(I < threshold)));
    
    intra_class_variance = w0 * var0 + w1 * var1;
end
