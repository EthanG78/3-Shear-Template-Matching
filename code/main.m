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

[base_M, base_N] = size(shapes);
[template_M, template_N] = size(square);

match = cross_corr(shapes, square, false);

%Find the maximum value
maxpt_1 = max(abs(match(:)));

%Find the pixel position of the maximum value
[y_1, x_1] = find(abs(match) == maxpt_1);

% Find the second strongest match
match(y_1, x_1) = 0;
maxpt_2 = max(abs(match(:)));
[y_2, x_2] = find(abs(match) == maxpt_2);

% Find the third strongest match
match(y_2, x_2) = 0;
maxpt_3 = max(abs(match(:)));
[y_3, x_3] = find(abs(match) == maxpt_3);

% Positions and sizes of rectangles to draw
position_1 = [x_1, y_1, template_N, template_M];
position_2 = [x_2, y_2, template_N, template_M];
position_3 = [x_3, y_3, template_N, template_M];

figure()
imshow(shapes);
drawrectangle('Position', position_1, 'Label', 'Template', 'Color', [1 0 0]);
drawrectangle('Position', position_2, 'Label', 'Template', 'Color', [1 0 0]);
drawrectangle('Position', position_3, 'Label', 'Template', 'Color', [1 0 0]);

% figure,subplot(1,2,1);imagesc(shapes(x:x+size(square,1),y:y+size(square,2),:));axis image;colormap(gray)
% subplot(1,2,2);imagesc(square);axis image;colormap(gray)
