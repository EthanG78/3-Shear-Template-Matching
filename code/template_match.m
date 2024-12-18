function template_match(base, template, threshold)
%TEMPLATE_MATCH Match all occurences of a template image in a provided
%base image using the 3-shear rotation template matching method.
%   template_match(base, template, threshold)
%   search for the provided template image in the provided base image 
%   using a frequency domain cross-correlation implementation and shear 
%   rotations of the template around the circle. Display an image of the 
%   base image with bounding boxes around all successful matching results.

    % Rotate the template through every angle of the circle, attempting to
    % match the rotated template to the base image and storing any matches
    matches = [];
    angles = [];
    for angle = 0:359
        % Rotate the template by the specified angle.
        template_rot = shear_rotation(template, angle);

        % Calculate the cross-correlation of the template image with the
        % base image using the frequency domain cross-correlation implementation
        % from cross_corr.m.
        matchingResult = cross_corr(base, template_rot, false);
    
        % Find the indicies of all values greater than the provided threshold.
        matchIndicies = find(abs(matchingResult) >= threshold);
        
        % Append to row vector of matches (this is slow).
        if (~isempty(matchIndicies))
            % Store the matches and the angles of those matches
            matches = [matches; matchIndicies];
            angles = [angles; (360 - angle) * ones(size(matchIndicies))];
        end
    end
    
    % Iterate through all matches and remove duplicates. We know that a match
    % is a duplicate if its coordinates in the image are within the dimensions
    % of the template being matched, i.e., the diagonal of the template.
    base_size = size(base);
    [temp_M, temp_N] = size(template); 
    Z_sqr = (temp_M/2)^2 + (temp_N/2)^2;
    deleted_indicies = [];
    for i = 1:length(matches)
        % If the index we are at has already been flagged for
        % removal, then skip it.
        if (any(deleted_indicies == i))
            continue;
        end
    
        [match_y, match_x] = ind2sub(base_size, matches(i));
        for j = 1:length(matches)
            if (i ~= j)
                [y, x] = ind2sub(base_size, matches(j));
    
                % Calculate the distance squared between these two matches,
                % if it is less than template_z_sqr then flag j for removal.
                dist = (match_x - x)^2 + (match_y - y)^2;
                if (dist <= 2 * Z_sqr)
                    deleted_indicies = [deleted_indicies j];
                end
            end
        end
    end
    
    % Delete all duplicate matches that have been flagged
    matches(deleted_indicies) = [];
    angles(deleted_indicies) = [];
    
    % The shear_rotation() function grows the template to the size
    % ZxZ where Z = 2*sqrt((M/2)^2 + (N/2)^2), where M, N are the
    % dimensions of the image being rotated. To properly identify the
    % bounds of the matches in the base image, add M/4 and N/4 to the x, y 
    % indicies, respectively.
    for i = 1:length(matches)
        [y, x] = ind2sub(base_size, matches(i));
        y = y + round(temp_N/4);
        x = x + round(temp_M/4);
        if (x <= base_size(2) && y <= base_size(1))
            matches(i) = sub2ind(base_size, y, x);
        end
    end
    
    % Display all of the matches found by the template matching algorithm.
    draw_rects(base, [temp_M, temp_N], matches, angles);
end