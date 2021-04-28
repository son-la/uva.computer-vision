% Input
number_of_input_channels = 3;
input_size = 64;
disp("Input size: " + input_size + "x" + input_size + "x" + number_of_input_channels);

% Convolutional layer 1
kernel_size = 5;
number_of_filter = 32;

disp("--- Convulational layer 1 ---");
[output_size, output_channels] = convolution_layer(input_size, number_of_input_channels, kernel_size, number_of_filter);


% Max pooling layer 1
number_of_input_channels = output_channels;
input_size = output_size;
kernel_size = 4;
stride = 4;

disp("--- Max pooling layer 1 ---");
[output_size, output_channels] = max_pooling_layer(input_size, number_of_input_channels, kernel_size, stride);

% Convolutional layer 2
number_of_input_channels = output_channels;
input_size = output_size;
kernel_size = 5;
number_of_filter = 32;

disp("--- Convulational layer 2 ---");
[output_size, output_channels] = convolution_layer(input_size, number_of_input_channels, kernel_size, number_of_filter);

% Max pooling layer 2
number_of_input_channels = output_channels;
input_size = output_size;
kernel_size = 4;
stride = 4;

disp("--- Max pooling layer 2 ---");
[output_size, output_channels] = max_pooling_layer(input_size, number_of_input_channels, kernel_size, stride);

% Flatten layer
number_of_input_channels = output_channels;
input_size = output_size;

disp("--- Flatten layer ---");
output_size = input_size * input_size * number_of_input_channels;
disp("Output size: " + output_size);
disp("Number of learnable parameters: " + 0);


% Dense layer 1 
number_of_neuron = 100;
input_size = output_size;

disp("--- Dense layer 1 ---");
output_size = dense_layer(input_size, number_of_neuron);

% Dense layer 2
number_of_neuron = 1;
input_size = output_size;

disp("--- Dense layer 2 ---");
output_size = dense_layer(input_size, number_of_neuron);


function [output_size, output_channels] = convolution_layer(input_size, number_of_input_channels, kernel_size, number_of_filter)
    padding = (kernel_size - 1)/2; % To avoid shrinking
    output_size = input_size - kernel_size + 1 + 2*padding;
    output_channels = number_of_filter;
    disp("Output size: " + output_size + "x" + output_size + "x" + output_channels);

    number_of_learnable_parameter_per_kernel = number_of_input_channels * kernel_size * kernel_size + 1; % Plust 1 for bias
    number_of_learnable_parameter = number_of_learnable_parameter_per_kernel * number_of_filter;
    disp("Number of learnable parameters: " + number_of_learnable_parameter);

    number_of_outputs = output_size * output_size * number_of_filter;
    number_of_scalar_multiplication = number_of_outputs * kernel_size * kernel_size * number_of_filter;
    disp("Number of scalar multiplication: " + number_of_scalar_multiplication);
end

function [output_size, output_channels] = max_pooling_layer(input_size, number_of_input_channels, kernel_size, stride)
    output_size = (input_size - kernel_size)/stride + 1;
    output_channels = number_of_input_channels;
    disp("Output size: " + output_size + "x" + output_size + "x" + output_channels);
    disp("Number of learnable parameters: " + 0);
end

function output_size = dense_layer(input_size, number_of_neuron)
    output_size = number_of_neuron;
    disp("Output size: " + output_size);

    number_of_learnable_parameter = (input_size + 1) * number_of_neuron;
    disp("Number of learnable parameters: " + number_of_learnable_parameter);
end