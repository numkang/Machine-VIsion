function R = find_R_from_n_and_theta(n, theta)
    % Calculate a rotational matrix R from given n and theta
    %     [ n1^2 + (1-n1^2)*cos  n1n2(1-cos)-n3sin  n1n3(1-cos)+n2sin ]
    % R = [ n1n2(1-cos)+n3sin    n2^2+(1-n2^2)cos   n2n3(1-cos)-n1sin ]
    %     [ n1n3(1-cos)-n2sin    n2n3(1-cos)+n1sin  n3^2+(1-n3^2)cos  ]
    
    R = zeros(3,3);
    for i = 1:3
        R(i,i) = n(i)^2 + (1-n(i)^2)*cosd(theta);
        
        j = i+1;
        if j > 3
            j = 1;
        end
        
        k = i-1;
        if k < 1;
            k = 3;
        end
        
        R(i,j) = n(i)*n(j)*(1-cosd(theta)) - n(k)*sind(theta);
        R(i,k) = n(i)*n(k)*(1-cosd(theta)) + n(j)*sind(theta);
    end
    
%     R(1,2) = n(1)*n(2)*(1-cosd(theta)) - n(3)*sind(theta);  
%     R(1,3) = n(1)*n(3)*(1-cosd(theta)) + n(2)*sind(theta);
%     R(2,1) = n(1)*n(2)*(1-cosd(theta)) + n(3)*sind(theta);
%     R(2,3) = n(2)*n(3)*(1-cosd(theta)) - n(1)*sind(theta);
%     R(3,1) = n(1)*n(3)*(1-cosd(theta)) - n(2)*sind(theta);
%     R(3,2) = n(2)*n(3)*(1-cosd(theta)) + n(1)*sind(theta);

end