% Matlab code for 1.2 Color correction

% Load the image
img = im2double(imread('white_balance_input.jpg'));

% Display the image and use ginput to pick a gray pixel
imshow(img);
[x, y] = ginput(1); % Allows you to pick one pixel in the figure
x = round(x);
y = round(y);

% Inverse gamma correction
img = img .^ 2.2;

% Increase brightness (linear multiplications)
brightnessFactor = 1.5; 
img = min(img * brightnessFactor, 1.0);

% Get the pixel value
pickedPixel = squeeze(img(y, x, :));

% Calculate the average of the R, G, B values of the input image
imgMean = mean(img, [1, 2]);
overallMean = mean(imgMean);

% Calculate gains for pixel-based correction
gainsPixelBased = overallMean ./ double(pickedPixel);

% Apply gains for pixel-based correction
correctedImgPixelBased = double(img);
for c = 1:3
    correctedImgPixelBased(:,:,c) = correctedImgPixelBased(:,:,c) * gainsPixelBased(c);
end
% Clipping to the [0, 1] range
correctedImgPixelBased(correctedImgPixelBased > 1) = 1; 

% Gray-world assumption for color correction
gainsGrayWorld = overallMean ./ double(imgMean);

% Apply the gains for gray-world correction
correctedImgGrayWorld = double(img);
for c = 1:3
    correctedImgGrayWorld(:,:,c) = correctedImgGrayWorld(:,:,c) * gainsGrayWorld(c);
end
% Clipping to the [0, 1] range
correctedImgGrayWorld(correctedImgGrayWorld > 1) = 1; 

% Apply gamma correction
img = img .^ (1/2.2);
correctedImgPixelBased = correctedImgPixelBased .^ (1/2.2);
correctedImgGrayWorld = correctedImgGrayWorld .^ (1/2.2);

% Display the original and corrected images 
figure;

% Original Image
subplot(1,3,1);
imshow(img);
title('Original Image');

% Pixel-based White Balance Correction
subplot(1,3,2);
imshow(correctedImgPixelBased);
title('Pixel-based Correction');

% Gray-world Assumption White Balance Correction
subplot(1,3,3);
imshow(correctedImgGrayWorld);
title('Gray-world Correction');
exportgraphics(gcf, 'white_balance_corrections_with_gamma_and_factor.png', 'Resolution', 500);