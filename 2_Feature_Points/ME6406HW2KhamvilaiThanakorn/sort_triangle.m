function [XY, L] = sort_triangle(XY)
    % Sorting the points of triangle in such a way that L1 > L2 > L3
    % Input: vector of triangle points (XY)
    % Output: vector of triangle points (XY)
    %         length of each side of the triangle (L)
    
    for i = 1:size(XY,2)
        j = i+1;
        if j == size(XY,2)+1
            j = 1;
        end
    
        L(i) = sqrt((XY(1,i)-XY(1,j))^2 + (XY(2,i)-XY(2,j))^2); % check length of each side of a triangle 
    end

    XY_temp = XY;
    L_temp = L;
    for i = 1:size(XY,2)
        % matching the length to each point L1 > L2 > L3
        [~,L_index] = max(L_temp);        
        L(:,i) = L_temp(:,L_index);       
        XY(:,i) = XY_temp(:,L_index);        
        L_temp(L_index) = nan;
    end    
end