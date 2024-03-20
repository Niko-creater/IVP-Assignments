%% Global Histogram Equalization
inputImage = imread('test.png');
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
imwrite(equalizedImage, 'test_global_hist_eq.png');
%% Local Histogram Equalization
inputImage = imread('test.png');
% Convert the input image from RGB to HSV
hsvImage = rgb2hsv(inputImage);

% Extract V-channel
vChannel = hsvImage(:,:,3);

% Apply local histogram equalization to the V-channel
windowSize = 5; % adjust window size here
equalizedChannel = local_hist_eq(vChannel, windowSize);

% Replacing the equalized V channel back into the HSV image
hsvImage(:,:,3) = equalizedChannel;

% Converting HSV images back to RGB
equalizedImage = hsv2rgb(hsvImage);

% Show and save the result
imshow(equalizedImage);
filename = ['test_local_hist_eq_window_size_' num2str(windowSize) '.png'];
imwrite(equalizedImage, filename);
%% Matting
bg_color_min = [0.47087,0.34673,0.66059]; 
bg_color_max = [0.49087,0.36673,0.68059]; 

alpha_mask = get_alpha_mask('dog.jpg', bg_color_min, bg_color_max);

f1 = imread('dog.jpg');
f2 = imread('2.jpg'); 

f2 = imresize(f2, [size(f1, 1), size(f1, 2)]);

f = uint8((alpha_mask) .* double(f1) + (1 - alpha_mask) .* double(f2));

imshow(f);

imwrite(f, 'new_dog.png');