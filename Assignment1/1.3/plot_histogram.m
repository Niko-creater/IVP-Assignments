% Matlab code for 1.3 Histograms
function plot_histogram(imagePath, option)
    % Input:
    %   imagePath: a string of image path
    %   option: if option is 1, then histogram of each channel plot
    %   separately, otherwise they plot in one graph.
    % Output:
    %   The color histograms plot of given image.

    % Load the image
    img = imread(imagePath);

    [rows, cols, ~] = size(img);
    num_pixels = rows * cols;
    
    % Separate the color channels
    redChannel = img(:, :, 1);
    greenChannel = img(:, :, 2);
    blueChannel = img(:, :, 3);

    redHistogram = zeros(1, 256);
    greenHistogram = zeros(1, 256);
    blueHistogram = zeros(1, 256);

    for i = 1:rows
        for j = 1:cols
            redPixelValue = redChannel(i, j);
            bluePixelValue = blueChannel(i, j);
            greenPixelValue = greenChannel(i, j);
            % Count the number of each intensity
            redHistogram(redPixelValue + 1) = redHistogram(redPixelValue + 1) + 1;
            blueHistogram(bluePixelValue + 1) = blueHistogram(bluePixelValue + 1) + 1;
            greenHistogram(greenPixelValue + 1) = greenHistogram(greenPixelValue + 1) + 1;
        end
    end

    % Calculate the cumulative distribution
    redCumulative = cumsum(redHistogram) / num_pixels;
    greenCumulative = cumsum(greenHistogram) / num_pixels;
    blueCumulative = cumsum(blueHistogram) / num_pixels;

    x = 0:1:255;


    if option == 1
        % Plot the histograms
        figure;
        subplot(2, 3, 1);
        bar(x, redHistogram, 'r');
        title('Red Channel Histogram');
        xlim([0 255]);
        
        subplot(2, 3, 2);
        bar(x, greenHistogram, 'g');
        title('Green Channel Histogram');
        xlim([0 255]);
        
        subplot(2, 3, 3);
        bar(x, blueHistogram, 'b');
        title('Blue Channel Histogram');
        xlim([0 255]);
        
        % Plot the cumulative distributions
        subplot(2, 3, 4);
        plot(x, redCumulative, 'r');
        title('Red Cumulative Distribution');
        xlim([0 255]);
        
        subplot(2, 3, 5);
        plot(x, greenCumulative, 'g');
        title('Green Cumulative Distribution');
        xlim([0 255]);
        
        subplot(2, 3, 6);
        plot(x, blueCumulative, 'b');
        title('Blue Cumulative Distribution');
        xlim([0 255]);
    else
        % Plot the histograms together for comparison
        figure;
        subplot(1, 2, 1); 
        hold on; 
        bar(x, redHistogram, 'r');
        bar(x, greenHistogram, 'g');
        bar(x, blueHistogram, 'b');
        title('RGB Channel Histograms');
        xlim([0 255]);
        legend('Red', 'Green', 'Blue');
        hold off;
        
        % Plot the cumulative distributions together
        subplot(1, 2, 2); 
        hold on; 
        plot(x, redCumulative, 'r', 'LineWidth', 2);
        plot(x, greenCumulative, 'g', 'LineWidth', 2);
        plot(x, blueCumulative, 'b', 'LineWidth', 2);
        title('RGB Cumulative Distributions');
        xlim([0 255]);
        legend('Red', 'Green', 'Blue');
        hold off;
        
        % Save the plot of result
        exportgraphics(gcf, 'histograms.png', 'Resolution', 500);
    end
end