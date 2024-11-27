function [matchingResult, matchIndicies] = template_match(base, template, threshold)
%TEMPLATE_MATCH Match all occurences of a template image in a provided
%base image using the frequency domain cross-correlation based on
%provided threshold.
%   [matchingResult, matchIndicies] = template_match(base, template, threshold)
%   search for the provided template image in the provided base image 
%   using a frequency domain cross-correlation implementation. Return 
%   the linear indicies of all matching results above the 
%   provided threshold in the matchIndicies array, as well as cross-
%   correlation result, matchingResult.

    % Calculate the cross-correlation of the template image with the
    % base image using the frequency domain cross-correlation implementation
    % from cross_corr.m.
    matchingResult = cross_corr(base, template, false);

    % Find the indicies of all values greater than the provided threshold.
    matchIndicies = find(abs(matchingResult) >= threshold);
end


%%% OLD:
 % % The current angle of rotation.
 %    angle = 0;
 % 
 %    % The global maximum "matching" value.
 %    max = 0;
 % 
 %    % Loop variable to continue matching.
 %    match = true;
 % 
 %    % Convert both input images to grayscale.
 %    baseImg = rgb2gray(baseImg);
 %    [M, N] = size(baseImg);
 %    templateImg = rgb2gray(templateImg);
 % 
 %    while (match)
 %        % Step 1: Rotate the template using custom 3 shear rotation
 %        % implementation that can be found in shear_rotation.m.
 %        rotated_template = shear_rotation(templateImg, angle);
 % 
 %        % Step 2/3: Convert the base image and rotated template image to
 %        % the frequency domain and perform the frequency domain
 %        % cross-correlation. Both of these steps, including padding of the
 %        % images, is accomplished in the custom cross-correlation
 %        % implementation that can be found in cross_corr.m.
 %        % matchingResult = cross_corr(baseImg, rotated_template);
 %        Ga = fft2(fftshift(baseImg));
 %        Gb = fft2(fftshift(rotated_template), M, N);
 %        matchingResult = ifft2((Ga.*conj(Gb))./abs(Ga.*conj(Gb)));
 % 
 %        figure()
 %        imshow(uint8(fftshift(matchingResult)));
 % 
 % 
 %        % Step 4: Determine the current maximum "matching" value and store
 %        % it to compare to our global value.
 %        current = 0;
 %        for i = 1:size(matchingResult, 1)
 %            for j = 1:size(matchingResult, 2)
 %                if (current <= matchingResult(i, j))
 %                    current = matchingResult(i, j);
 %                end
 %            end
 %        end
 % 
 %        % Step 5: Check if we have reached a maximum "matching" value and 
 %        % are starting to decline, if so end matching.
 %        if (current >= max)
 %            max = current;
 %        else
 %            match = false;
 %        end
 % 
 %        % Step 6: Increase the angle for the next round of matching.
 %        angle = angle + 10;
 %    end
 % 
 %    % TODO:
 %    nMatches = 0;