%%% main.m
%%%
%%% Author: Ethan Garnier
%%% Date: Fall 2024
euro = imread('..\assets\1-euro.png');
euro = rgb2gray(euro);
figure();
imshow(euro);


rotated_euro = shear_rotation(euro, 45);
figure();
imshow(rotated_euro);