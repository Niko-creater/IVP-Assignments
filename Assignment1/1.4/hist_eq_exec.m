% Matlab code for 1.4 Histogram Equalization
%% Global Histogram Equalization

inputImage = imread('ferrari.JPG');
% Convert the input image from RGB to HSV
hsvImage = rgb2hsv(inputImage);

% Extract V-channel
vChannel = hsvImage(:,:,3);

% Apply global histogram equalization to the V-channel
equalizedChannel = global_hist_eq(vChannel);

% Replacing the equalized V channel back into the HSV image
hsvImage(:,:,3) = equalizedChannel;

% Converting HSV images back to RGB
equalizedImage = hsv2rgb(hsvImage);

% Show and save the result
imshow(equalizedImage);
imwrite(equalizedImage, 'global_hist_eq.png');

%% Local Histogram Equalization

inputImage = imread('ferrari.JPG');
% Convert the input image from RGB to HSV
hsvImage = rgb2hsv(inputImage);

% Extract V-channel
vChannel = hsvImage(:,:,3);

% Apply local histogram equalization to the V-channel
windowSize = 200; % adjust window size here
equalizedChannel = local_hist_eq(vChannel, windowSize);

% Replacing the equalized V channel back into the HSV image
hsvImage(:,:,3) = equalizedChannel;

% Converting HSV images back to RGB
equalizedImage = hsv2rgb(hsvImage);

% Show and save the result
imshow(equalizedImage);
filename = ['local_hist_eq_window_size_' num2str(windowSize) '.png'];
imwrite(equalizedImage, filename);

%% Locally Adaptive Histogram Equalization

inputImage = imread('ferrari.JPG');
% Convert the input image from RGB to HSV
hsvImage = rgb2hsv(inputImage);

% Extract V-channel
vChannel = hsvImage(:,:,3);

% Apply local histogram equalization to the V-channel
windowSize = 20; % adjust window size here
equalizedChannel = adp_local_hist_eq(vChannel, windowSize);

% Replacing the equalized V channel back into the HSV image
hsvImage(:,:,3) = equalizedChannel;

% Converting HSV images back to RGB
equalizedImage = hsv2rgb(hsvImage);

% Show and save the result
imshow(equalizedImage);
filename = ['adp_local_hist_eq' num2str(windowSize) '.png'];
imwrite(equalizedImage, filename);

%% Smoothed Local Histogram Equalization

inputImage = imread('ferrari.JPG');

% Convert the input image from RGB to HSV
hsvImage = rgb2hsv(inputImage);

vChannel = hsvImage(:,:,3);

equalizedChannel = local_hist_eq(vChannel, 50);

% The equalized image is smoothed using a mean filter with a window size of 5x5
smoothedEqualizedImage = imfilter(equalizedChannel, fspecial('average', [5 5]));

hsvImage(:,:,3) = smoothedEqualizedImage;

smoothedEqualizedImageRGB = hsv2rgb(hsvImage);

imshow(smoothedEqualizedImageRGB);

imwrite(smoothedEqualizedImageRGB, 'smoothed_equalized_image.png');