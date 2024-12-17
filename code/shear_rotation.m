function rotated_img = shear_rotation(img, angle)
%SHEAR_ROTATION A 3 shear rotation of an image.
%   rotated_img = shear_rotation(img, angle) rotate the provided
%   image, img, around its center by angle degrees and return
%   this rotated image

    % Store the provided angle in radians.
    theta = deg2rad(angle);

    % Create the image to be rotated. It must be a padded version
    % of the original image to allow for the rotation to not be clipped.
    % The minimum padding required, i.e., 2*z, where z is the hypotenuse of
    % the width and height of the image being rotated.
    [orig_M, orig_N] = size(img); 
    z = ceil(sqrt((orig_M/2)^2 + (orig_N/2)^2));
    M = 2*z;
    N = M;
    rotated_img = uint8(255 * ones(M, N));

    % Compute the mid points by which we rotate around in original image.
    orig_mid_x = round((orig_N + 1) / 2);
    orig_mid_y = round((orig_M + 1) / 2);

    % Compute the mid points by which we rotate around in new image.
    mid_x = round((N + 1) / 2);
    mid_y = round((M + 1) / 2);

    % Define the rotations variables used in shearing.
    a = -tan(theta/2);
    b = sin(theta);

    % Perform the rotation
    for j = 0:orig_N-1
        for i = 0:orig_M-1
            % Define the x and y coordinates relative
            % to the center of the image.
            x = j - orig_mid_x;
            y = i - orig_mid_y;

            % Three Shear Rotation steps from Paeth.
            x1 = round(x+y*a);
            y1 = round(x1*b+y);
            x1 = round(x1+y1*a);       
    
            % Rotate around the center of the new image.
            x1 = x1 + mid_x;
            y1 = y1 + mid_y;
            
            % Update the pixel values in the new rotated image.
            if (x1 > 0 && y1 > 0 && x1 <= N && y1 <= M)
                rotated_img(y1, x1) = img(i + 1, j + 1);
            end
        end
    end
end