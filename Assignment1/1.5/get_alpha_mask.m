function alpha_mask = get_alpha_mask(img, bg_color_min, bg_color_max)
    % Input:
    %   img: the given image.
    %   bg_color_min: the matrix for background color filter which contains
    %   the lower bound.
    %   bg_color_max: the matrix for background color filter which contains
    %   the upper bound.
    % Output:
    %   alpha_mask: the mask we calculated for later composition.\

    % Read the image
    img = imread(img);
    img = rgb2hsv(img);
    
    alpha_mask = zeros(size(img, 1), size(img, 2));
    

    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            % Get the current pixel value
            pixel = squeeze(img(i,j,:))';
            result = false;
            % Check for very filter if the pixel should be filtered
            for k = 1:size(bg_color_min, 1)
                result = result || all(pixel >= bg_color_min(k,:)) && all(pixel <= bg_color_max(k,:));
            end
            if result
            % If the pixel belong to background, then assign 0
                alpha_mask(i,j) = 0;
            else
                % else assign 1
                alpha_mask(i,j) = 1;
            end
        end
    end
    % Smooth the mask to remove hardness from the edges
    alpha_mask = imgaussfilt(double(alpha_mask), 2);

end
