% Matlab code for 1.4 Histogram Equalization
function equalizedChannel = global_hist_eq(inputChannel)
    % Input:
    %   inputChannel: a V channel of a HSV image.
    % Output:
    %   equalizedChannel: globally equalized given V channel.

    % Get image size
    [rows, cols] = size(inputChannel);
    
    % Calculate Histogram
    histValues = zeros(1, 256);
    for i = 1:rows
        for j = 1:cols
            pixelValue = round(inputChannel(i, j) * 255); 
            histValues(pixelValue + 1) = histValues(pixelValue + 1) + 1;
        end
    end
    
    % Calculate the CDF
    cdf = cumsum(histValues) / (rows * cols);

    % Create mappings for histogram equalization
    equalizedValues = cdf * 255;
    
    % Apply equalization mapping and map back to the 0-1 range
    equalizedChannel = zeros(size(inputChannel));
    for i = 1:rows
        for j = 1:cols
            pixelValue = round(inputChannel(i, j) * 255);
            equalizedChannel(i, j) = equalizedValues(pixelValue + 1) / 255;
        end
    end
end