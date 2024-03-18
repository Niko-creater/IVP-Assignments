function [counts, edges] = hist_counts(data, numBins)
    % Flatten the input matrix to a vector
    dataVector = data(:);
    
    % Determine the range of the data
    dataMin = min(dataVector);
    dataMax = max(dataVector);
    
    % Calculate bin edges
    binWidth = (dataMax - dataMin) / numBins;
    edges = dataMin:binWidth:dataMax;
    if length(edges) > numBins  % Ensure numBins bins by adjusting the last edge if necessary
        edges(end) = dataMax + binWidth;  % Extend the last bin to include the max value
    else
        edges(numBins+1) = dataMax + binWidth;  % Append an edge to include the max value
    end
    
    % Initialize counts
    counts = zeros(1, numBins);
    
    % Count the data points in each bin
    for i = 1:numBins
        if i == numBins
            % Include the upper edge in the last bin
            inBin = dataVector >= edges(i) & dataVector <= edges(i+1);
        else
            inBin = dataVector >= edges(i) & dataVector < edges(i+1);
        end
        counts(i) = sum(inBin);
    end
end

