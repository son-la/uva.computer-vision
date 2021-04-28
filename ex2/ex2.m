clear all, close all, clc

load('data2.mat')

%% IMPLEMENT FISHER CLASSIFIER

% plot training data and separation line
figure(1)
hold on
plot(X0(:,1), X0(:,2), 'bx');
plot(X1(:,1), X1(:,2), 'ro');
line(4*[-w(1) w(1)],4*[-w(2),w(2)],'Color','k', 'LineStyle', '--', 'LineWidth', 2)
legend('0', '1', 'w');
axis equal
grid on
hold off

%% Compute scores and threshold

figure(2)
histogram(score0);
hold on
histogram(score1);
xline(c, 'r--', 'LineWidth', 2)
hold off;
legend('0', '1', 'c')
hold off
