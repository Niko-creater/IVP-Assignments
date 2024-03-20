% Matlab code for 1.5 Matting

% By bg_color_min and bg_color_max we manually set the filter, notice that
% each row correspond to each filter (like first row of bg_color_min is the
% min HSV value of filter). 
% Minimum HSV value of the background color
bg_color_min = [0.30, 0.11, 0.15; 0.30, 0.05, 0.70]; 
% Maximum HSV value of the background color
bg_color_max = [0.34, 0.31, 0.85; 0.34, 0.20, 0.95]; 

% Get the mask
alpha_mask = get_alpha_mask('cat.jpg', bg_color_min, bg_color_max);

f1 = imread('cat.jpg'); % target picture
f2 = imread('1.jpg'); % background picture

% Resize the background picture
f2 = imresize(f2, [size(f1, 1), size(f1, 2)]); 

% Combine two images based on mask value
f = uint8((alpha_mask) .* double(f1) + (1 - alpha_mask) .* double(f2));

% Show and save result
imshow(f);
imwrite(f, 'composite_image.png');