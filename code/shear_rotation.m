%%% shear_rotation.m
%%% 
%%% Author: Ethan Garnier
%%% Date: Fall 2024

function rotated_img = shear_rotation(img, angle)
%shear_rotation  3 shear rotation if an image.
%   rotated_img = shear_rotation(img, angle) rotate the provided
%   image, img, around its center by angle degrees and return
%   this rotated image

    % Store the provided angle in radians
    theta = deg2rad(angle);

    % Pad the original image
    [M, N] = size(img); 
    diag = sqrt(M^2 + N^2); 
    row_pad = ceil(diag - M) + 2;
    col_pad = ceil(diag - N) + 2;
    padded_img = uint8(zeros(M + row_pad, N + col_pad));
    padded_img(ceil(row_pad/2):(ceil(row_pad/2)+M-1),ceil(col_pad/2):(ceil(col_pad/2)+N-1)) = img;

    % figure();
    % imshow(padded_img);

    % Create the image to be rotated
    [pad_M, pad_N] = size(padded_img);
    rotated_img = uint8(zeros(pad_M, pad_N));

    % Compute the mid points by which we rotate around
    mid_x = ceil((pad_N + 1) / 2);
    mid_y = ceil((pad_M + 1) / 2);

    % Define the shear matricies and the rotation transform
    a = -tan(theta/2);
    b = sin(theta);
    shear_1 = [1 a; 0 1];
    shear_2 = [1 0; b 1];
    rot_mat = shear_1 * shear_2 * shear_1;

    % Perform the rotation
    for i = 0:pad_N - 1
        for j = 0:pad_M - 1
            % Multiply the current x and y by the
            % rotation matrix. Subtract mid point
            % to ensure we rotate around the center.
            xy = rot_mat * [i - mid_x ; j - mid_y];

            % Round the rotated coordinates to a whole
            % number and add back the mid points.
            x = round(xy(1)) + 1 + mid_x;
            y = round(xy(2)) + 1 + mid_y;

            % x = round(i + a*b*i + 2*a*j + a*a*b*j) + 1;
            % y = round(b*i + a*b*j + 1) + 1;

            if (x >= 1 && y >= 1 && x <= pad_N && y <= pad_M)
                rotated_img(x, y) = padded_img(i + 1, j + 1);
                % rotated_img(i + 1, j + 1) = padded_img(x, y);
            end
        end
    end
end