% Matlab Code for 1.1 Tone mapping & Linearization

% Load the Ferrari image
ferrariImg = imread('ferrari.JPG');

% Convert to double type in the range [0, 1]
ferrariImgDouble = im2double(ferrariImg);

gamma = 2.2; 

% Linearize the image by inverse gamma correction
linearizedImg = ferrariImgDouble .^ gamma;

% Increase brightness (linear multiplications)
brightnessFactor = 1.6; 
brighterImg = min(linearizedImg * brightnessFactor, 1.0);

%contrast enhancement (exponential functions)
contrastEnhancedImg = brighterImg .^ (1.1);

% Apply gamma correction 
displayImg = contrastEnhancedImg .^ (1/gamma);

% Plot the graph we need
subplot(1, 2, 1);
imshow(ferrariImg);
title('Original Image');

subplot(1, 2, 2);
imshow(displayImg);
title('Processed Image');

% Store the plot
exportgraphics(gcf, 'linearization.png', 'Resolution', 500);