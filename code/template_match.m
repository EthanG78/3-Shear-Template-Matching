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