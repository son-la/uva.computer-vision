
clear all, close all, clc

I = double(imread("cameraman.tif"));
I = [1 2 1; 10 12 15];
tmin = otsu_thresholding(I)
