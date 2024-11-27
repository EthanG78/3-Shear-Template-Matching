%%% main.m
%%%
%%% Author: Ethan Garnier
%%% Date: Fall 2024
square = imread('..\assets\square.png');
shapes = imread('..\assets\shapes.png');

square = rgb2gray(square);
shapes = rgb2gray(shapes);

% figure();
% imshow(square);
% 
% figure();
% imshow(shapes);

[match, matchIndicies] = template_match(shapes, square, 0.06);

draw_rects(shapes, size(square), matchIndicies, zeros(size(matchIndicies)));