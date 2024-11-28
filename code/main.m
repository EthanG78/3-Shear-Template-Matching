%%% main.m
%%%
%%% Author: Ethan Garnier
%%% Date: Fall 2024
square = imread('..\assets\square.png');
shapes = imread('..\assets\shapes.png');

square = rgb2gray(square);
shapes = rgb2gray(shapes);

% Maybe LPF the template?
% square_rot_blur = imgaussfilt(square_rot, 1);

for angle = 0:359
    % Rotate the template by the specified angle.
    template_rot = shear_rotation(square, angle);

    % Try to perform template matching using the rotated template.
    [match, matchIndicies] = template_match(shapes, template_rot, 0.03);

    % Is there any matches?
    if (size(matchIndicies, 1) > 0)
        % Re-map the angle as shear_rotation rotates counter-clockwise but
        % draw_rects rotates clockwise.
        clockwise_angle = 360 - angle;

        % Draw all template matches
        draw_rects(shapes, size(template_rot), matchIndicies, clockwise_angle * ones(size(matchIndicies)));
    end
end
