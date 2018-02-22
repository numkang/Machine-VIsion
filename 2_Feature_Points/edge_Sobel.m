function [Gx,Gy,G] = edge_Sobel(I)
    % Edge Detection Function
    % Input: image and threshold
    % Output: Gradient in horizontal, vertical, and both direction
    
    Hx = [-1 -2 -1; 0 0 0; 1 2 1];
    Hy = [-1 0 1; -2 0 2; -1 0 1];
    M = size(I,1); % # of rows I
    N = size(I,2); % # of columns I

    Gx = zeros(M,N);
    Gy = zeros(M,N);
    for i = 2:M-1
        for j = 2:N-1
            Gx(i,j) = sum(sum(Hx.*double(I(i-1:i+1,j-1:j+1)))); % convolution integral in x direction
            Gy(i,j) = sum(sum(Hy.*double(I(i-1:i+1,j-1:j+1)))); % convolution integral in y direction       
        end
    end
    G = uint8(round(sqrt(Gx.^2+Gy.^2)));
    
end