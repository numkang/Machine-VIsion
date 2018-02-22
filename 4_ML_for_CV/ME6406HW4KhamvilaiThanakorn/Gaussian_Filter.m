function J = Guassian_Filter(I, sigma)
    % Guassian Filter Function
    % Input: image and sigma
    % Output: Guassian Filtered Image
    
    mask_size = 3*sigma*2 + 1;
    L = floor(mask_size/2);   
    for m = 1:mask_size
        for n = 1:mask_size
            G(m,n) = 1/(2*pi*sigma^2)*exp(-((m-L-1).^2+(n-L-1).^2)/(2*sigma^2));
        end
    end

    M = size(I,1); % # of rows I
    N = size(I,2); % # of columns I

    II = [zeros(L,N+2*L); zeros(M,L) I zeros(M,L); zeros(L,N+2*L)];
    for i = 1:M
        for j = 1:N
            J(i,j) = uint8(sum(sum(G(1:mask_size,1:mask_size).*double(II(i:i+2*L,j:j+2*L)))));        
        end
    end    
end