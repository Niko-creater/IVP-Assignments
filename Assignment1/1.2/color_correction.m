% Matlab code for 1.2 Color correction

% Load the image
img = imread('white_balance_input.jpg');


% Display the image and use ginput to pick a gray pixel
imshow(img);
[x, y] = ginput(1); % Allows you to pick one pixel in the figure
x = round(x);
y = round(y);

% Get the pixel value
pickedPixel = squeeze(img(y, x, :));

%% Pixel-based correction:
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
correctedImgPixelBased(correctedImgPixelBased > 255) = 255;
correctedImgPixelBased = uint8(correctedImgPixelBased);

%% Gray-world assumption:
% Calculate gains for gray-world correction
gainsGrayWorld = overallMean ./ double(imgMean);

% Apply the gains for gray-world correction
correctedImgGrayWorld = double(img);
for c = 1:3
    correctedImgGrayWorld(:,:,c) = correctedImgGrayWorld(:,:,c) * gainsGrayWorld(c);
end
correctedImgGrayWorld(correctedImgGrayWorld > 255) = 255;
correctedImgGrayWorld = uint8(correctedImgGrayWorld);

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

% Store the plot of result
exportgraphics(gcf, 'white_balance_corrections.png', 'Resolution', 500);
