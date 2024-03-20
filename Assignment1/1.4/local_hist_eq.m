% Matlab code for 1.4 Histogram Equalization
function equalizedChannel = local_hist_eq(inputChannel, windowSize)
    % Input:
    %   inputChannel: a V channel of a HSV image.
    %   windowSize: the size of square window which used for divide the
    %   whole channel.
    % Output:
    %   equalizedChannel: locally equalized given V channel.

    % Get image size
    [rows, cols] = size(inputChannel);
    equalizedChannel = zeros(size(inputChannel));
    
    % Construct the grid with given window size
    numRows = ceil(rows / windowSize);
    numCols = ceil(cols / windowSize);
    
    for i = 0:numRows-1
        for j = 0:numCols-1
            % Calculate the boundary of the window
            rowMin = i * windowSize + 1;
            rowMax = min((i + 1) * windowSize, rows);
            colMin = j * windowSize + 1;
            colMax = min((j + 1) * windowSize, cols);
            
            % Get the current window
            window = inputChannel(rowMin:rowMax, colMin:colMax);
            
            % Equalize the window
            equalizedWindow = global_hist_eq(window);
            
            % Copy the equalized window back to the appropriate location
            equalizedChannel(rowMin:rowMax, colMin:colMax) = equalizedWindow;
        end
    end
end
