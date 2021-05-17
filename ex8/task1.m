%% TASK 1: Robust circle estimation
% AUTHOR: Son La
% STUDENT NUMBER: y107227 

clear all, close all, clc

load('points.mat', 'X') % each column in X is a 2D point
m = length(X); % number of points
sigma = 1; %standard deviation

p = 0.999; % probability to pick at least once an outlier-free sample

s = 3; % minimum number of points to estimate the circle equation

% initialize
N=Inf; % maximum number of iterations
iter_count=0; % how many iterations have been done so far
max_inliers=0; % number of inliers for the best model so far
t = sigma*sqrt(3.84);
best_inliers = []; %indices of the best inliers from X. For example if the
% 1 3 and 5 point in X are inliers then best_inliers = [1,3,5]
e = 1;

while(N>iter_count)
    % Pick s random of unique points
    picked_points = randperm(m,s);
    
    % Determine the circle parameters
    [R, xcyc] = fit_circle(X(:, picked_points)');
    
    % find inliers
    num_inliers = sum(abs(cellfun(@norm, (num2cell(xcyc - X, 1))) - R) <= t,'all');   

    % update best_inliers if #inliers > max_inliers
    if num_inliers > max_inliers
        max_inliers = num_inliers;
        best_inliers = picked_points;
    end    
    
    % update outliers ratio
    e = (m-max_inliers)/m;    
    
    % update N
    N = log(1-p)/log((1-(1-0.5)^s));
    
    % update iter count
    iter_count = iter_count+1;
end

% compute circle center and radius using LS on the inliers
[r, C] = fit_circle_through_3_points(X(:, best_inliers)');


%%  PLOTTING THE RESULTS
% Note this code assumes the radius is stored in the variable r and the
% center in the 2x1 array C.

phi = linspace(0, 2*pi, m);
X_est = C+r*[cos(phi); sin(phi)];
plot(X(1,:), X(2,:), 'bo', X_est(1,:), X_est(2,:), 'r-')
axis equal
C
r

%% Helper function
function [R,xcyc] = fit_circle(ABC)
    % https://goodcalculators.com/best-fit-circle-least-squares-calculator/
    X = ABC(:,1);
    Y = ABC(:,2);
    A = [sum(X.^2) sum(X.*Y) sum(X);...
      sum(X.*Y) sum(Y.^2) sum(Y);...
      sum(X) sum(Y) length(X)];
    B = [sum(X.*(X.^2+Y.^2), 'all'); sum(Y.*(X.^2+Y.^2), 'all'); sum(X.^2+Y.^2, 'all')] ;
    
    X = linsolve(A,B);
    xcyc = [X(1)/2; X(2)/2];
    R = sqrt(4*X(3) + X(1)^2 + X(2)^2)/2;
end