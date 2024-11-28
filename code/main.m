%%% main.m
%%%
%%% Author: Ethan Garnier
%%% Date: Fall 2024
square = imread('..\assets\square.png');
shapes = imread('..\assets\shapes.png');

square = rgb2gray(square);
shapes = rgb2gray(shapes);

% figure();
% imshow(shapes);

% figure();
% imshow(square); 

square_rot_45 = shear_rotation(square, 45);

figure()
imshow(square_rot_45);

[match, matchIndicies] = template_match(shapes, square_rot_45, 0.02);

draw_rects(shapes, size(square), matchIndicies, zeros(size(matchIndicies)));