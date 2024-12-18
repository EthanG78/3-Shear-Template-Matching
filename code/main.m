%%% main.m
%%%
%%% Author: Ethan Garnier
%%% Date: Fall 2024
coins = imread('..\assets\euro-coins.jpg');
euro = imread('..\assets\individual-euro.jpg');
square = imread('..\assets\square.png');
shapes = imread('..\assets\shapes.png');
triangle = imread('..\assets\triangle.png');
circle = imread('..\assets\circle.png');

% Template matching on shapes examples
square_template = rgb2gray(square);
triangle_template = rgb2gray(triangle);
circle_template = rgb2gray(circle);
shapes_base = rgb2gray(shapes);

template_match(shapes_base, square_template, 0.0275);
template_match(shapes_base, triangle_template, 0.029);
template_match(shapes_base, circle_template, 0.04);

% Template matching on coins examples
euro_template = rgb2gray(euro);
coins_base = rgb2gray(coins);

template_match(coins_base, euro_template, 0.0083);