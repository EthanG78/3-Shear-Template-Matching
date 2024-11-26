function rotated_img = shear_rotation(img, angle)
%SHEAR_ROTATION A 3 shear rotation of an image.
%   rotated_img = shear_rotation(img, angle) rotate the provided
%   image, img, around its center by angle degrees and return
%   this rotated image

    % Store the provided angle in radians
    theta = deg2rad(angle);

    % Create the image to be rotated
    [M, N] = size(img); 
    rotated_img = uint8(zeros(M, N));

    % Compute the mid points by which we rotate around
    mid_x = ceil((N + 1) / 2);
    mid_y = ceil((M + 1) / 2);

    % Define the shear matricies and the rotation transform
    a = -tan(theta/2);
    b = sin(theta);
    shear_1 = [1 a; 0 1];
    shear_2 = [1 0; b 1];
    rot_mat = shear_1 * shear_2 * shear_1;

    % Perform the rotation
    for i = 0:M-1
        for j = 0:N-1
            % Multiply the current x and y by the
            % rotation matrix. Subtract mid point
            % to ensure we rotate around the center.
            xy = rot_mat * [i - mid_x ; j - mid_y];

            % Round the rotated coordinates to a whole
            % number and add back the mid points.
            x = round(xy(1)) + 1 + mid_x;
            y = round(xy(2)) + 1 + mid_y;

            if (x >= 1 && y >= 1 && x <= N && y <= M)
                rotated_img(x, y) = img(i + 1, j + 1);
            end
        end
    end
end