function plot_color_histogram(imagePath)
    % Load the image
    img = imread(imagePath);
    
    % Separate the color channels
    redChannel = img(:, :, 1);
    greenChannel = img(:, :, 2);
    blueChannel = img(:, :, 3);
    
    % Number of bins for the histogram
    numBins = 256;
    
    % Calculate the histograms
    [redHistogram, redBinEdges] = hist_counts(redChannel, numBins);
    [greenHistogram, greenBinEdges] = hist_counts(greenChannel, numBins);
    [blueHistogram, blueBinEdges] = hist_counts(blueChannel, numBins);
    
    % Calculate the cumulative distribution
    redCumulative = cumsum(redHistogram) / numel(redChannel);
    greenCumulative = cumsum(greenHistogram) / numel(greenChannel);
    blueCumulative = cumsum(blueHistogram) / numel(blueChannel);
    
    % Plot the histograms
    figure;
    subplot(2, 3, 1);
    bar(redBinEdges(1:end-1), redHistogram, 'r');
    title('Red Channel Histogram');
    xlim([0 numBins-1]);
    
    subplot(2, 3, 2);
    bar(greenBinEdges(1:end-1), greenHistogram, 'g');
    title('Green Channel Histogram');
    xlim([0 numBins-1]);
    
    subplot(2, 3, 3);
    bar(blueBinEdges(1:end-1), blueHistogram, 'b');
    title('Blue Channel Histogram');
    xlim([0 numBins-1]);
    
    % Plot the cumulative distributions
    subplot(2, 3, 4);
    plot(redBinEdges(1:end-1), redCumulative, 'r');
    title('Red Cumulative Distribution');
    xlim([0 numBins-1]);
    
    subplot(2, 3, 5);
    plot(greenBinEdges(1:end-1), greenCumulative, 'g');
    title('Green Cumulative Distribution');
    xlim([0 numBins-1]);
    
    subplot(2, 3, 6);
    plot(blueBinEdges(1:end-1), blueCumulative, 'b');
    title('Blue Cumulative Distribution');
    xlim([0 numBins-1]);
end
