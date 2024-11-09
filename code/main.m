%%% main.m
%%%
%%% Author: Ethan Garnier
%%% Date: Fall 2024
euro = imread('..\assets\1-euro.png');
coins = imread('..\assets\euro-coins.jpg');

figure();
imshow(euro);

figure()
imshow(coins);

[matchingResult, nMatches] = template_match(euro, euro);
figure();
imshow(matchingResult);
