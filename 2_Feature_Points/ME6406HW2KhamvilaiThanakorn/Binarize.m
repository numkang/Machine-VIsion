function I_BW = Binarize(I_gray, thres)
    % Binarization Function
    % Input: image and threshold
    % Output: binarized image
    
    M = size(I_gray,1); % # of rows I_gray
    N = size(I_gray,2); % # of columns I_gray
    min_level = 0; % minimum intensity of I_gray
    max_level = 255; % maximum intensity of I_gray

    I_BW = double(I_gray)-thres*ones(M,N); % seperated between the intensity that higher/lower than threshold
    I_BW = max(min_level,I_BW); % change the intensity that lower than the threshold to the minimun intensity
    I_BW = I_BW*(max_level)~=(min_level); % change all intensity beside the lowest one to the maximum intensity
end