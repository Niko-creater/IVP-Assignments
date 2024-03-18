% Load the Ferrari image
ferrariImage = imread('ferrari.JPG');

% Convert to double type in the range [0, 1]
ferrariImageDouble = im2double(ferrariImage);

gamma = 2.2; 

% Linearize the image
linearizedImage = ferrariImageDouble .^ gamma;

brightnessFactor = 1.6; 
brighterImage = min(linearizedImage * brightnessFactor, 1.0);

contrastEnhancedImage = brighterImage .^ (1.1);

% displayImage = min(contrastEnhancedImage, 1);
displayImage = contrastEnhancedImage .^ (1/gamma);

subplot(1, 2, 1);
imshow(ferrariImage);
title('Original Image');

subplot(1, 2, 2);
imshow(displayImage);
title('Processed Image');
