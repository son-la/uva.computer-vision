%% TASK 3: LEAST SQUARES AND OVERFITTING
clear all, close all, clc

load('task3_data.mat', 'x','y');

lam = 1;
figure;
for n = 0:2:14
    th_LS = poly_ls(x, y, n);
    th_ridge = poly_ridge(x, y, n, lam);
    
    xx = linspace(min(x), max(x), 100)';
    yy = secret_function(xx);
    yy_LS = xx.^(n:-1:0)*th_LS;
    yy_ridge = xx.^(n:-1:0)*th_ridge;
    
    subplot(2,4,n/2+1)
    hold on;
    plot(xx, yy, 'g-');
    plot(x, y, 'ko');
    plot(xx, yy_LS, 'r-');
    plot(xx, yy_ridge, 'b-');
    hold off
    title(['n=',num2str(n)]);
    legend('correct', 'points', 'LS', 'ridge', 'location', 'best')
    grid on; xlabel('x'); ylabel('y')
end
