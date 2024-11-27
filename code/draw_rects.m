function draw_rects(image, dims, indicies, rotations)
%DRAW_RECTS Draw rectangles in the provided image at specified locations
%and with specified rotations and sizes.
%   draw_rects(image, size, indicies, rotations)
%   Draw rectangles, using the drawrectangle() function, at the provided
%   linear indicies within the provided image. Each rectangle has width 
%   and height as defined by the provided dims vector and is rotated
%   clockwise by the angles specified in the rotations vector, in degrees.
%   This function does not return anything, it simply displays a new
%   figure of the provided image with the newly drawn rectangles.

    % If the indicies and rotations vectors sizes do not match, return.
    n_rectangles = size(indicies, 1);
    if (n_rectangles ~= size(rotations, 1))
        return;
    end

    % If the provided size vector is incorrectly formatted or has
    % incorrect values, return.
    if (size(dims, 2) ~= 2 || ~all(dims > 0))
        return
    end

    % Size of image to be displayed.
    image_size = size(image);
    
    % Create a new figure displaying the base image.
    figure()
    imshow(image);

    % Iterate through the provided indicies and rotations
    % vectors to draw each requested rectangle.
    for i = 1:n_rectangles
        % Convert the linear index to x, y indicies.image_size
        [y, x] = ind2sub(image_size, indicies(i));
    
        % Define a bounding box to highlight matches template.
        box = [x, y, dims(2), dims(1)];
    
        % Draw the bounding box in the base image.
        drawrectangle('Position', box, 'RotationAngle', rotations(i), 'Label', sprintf('%d', i), 'Color', [1 0 0]);
    end
end