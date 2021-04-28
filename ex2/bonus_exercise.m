%% ASSIGNMENT: Gradient descent
% AUTHOR: Son La
% STUDENT NUMBER: y107227
clear all, close all, clc

% Inputs
x1 = 1;
x2 = 2;

% Weights value
w1 = 1;
w2 = -1;
b1 = 1;
w3 = 4;
w4 = -1;
b2 = 0;

t = 1;

disp("Value of the output y with the given values: ")
z1 = w1 * x1 + w2 * x2  + b1;
y1 = sigmoid_function(z1);
z2 = w3 * y1 + w4 * x2 + b2;
y = sigmoid_function(z2)
disp("Loss value: ")
loss = loss_function(y, t)

disp("Values of the partial derivative with the given value: ")
dE_over_dw4 =  (y -t)*y*(1-y)*x2
dE_over_dw3 =  (y -t)*y*(1-y)*y1
dE_over_db2 =  (y -t)*y*(1-y)
dE_over_dw2 =  (y -t)*y*(1-y)*w3*y1*(1-y1)*x2
dE_over_dw1 =  (y -t)*y*(1-y)*w3*y1*(1-y1)*x1
dE_over_db1 =  (y -t)*y*(1-y)*w3*y1*(1-y1)

disp("Updated parameter values: ")
w4 = w4 - dE_over_dw4
w3 = w3 - dE_over_dw3
w2 = w2 - dE_over_dw2
w1 = w1 - dE_over_dw1
b2 = b2 - dE_over_db2
b1 = b1 - dE_over_db1

disp("Value of the output y with the updated parameters: ")
z1 = w1 * x1 + w2 * x2  + b1;
y1 = sigmoid_function(z1);
z2 = w3 * y1 + w4 * x2 + b2;
y = sigmoid_function(z2)

disp("Loss value with the updated parameters")
loss = loss_function(y, t)

disp("The loss become less than with the orignal parameters.")

function y = sigmoid_function(x)
    y = 1/(1+exp(-x));
end

function E = loss_function(y, t)
    E = 1/2 * (y-t)^2;
end