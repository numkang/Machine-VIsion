function [n, theta] = find_n_theta_from_R(R)
    % calculate n and theta from a given rotational matrix R
    %     [ r11 r12 r13 ]
    % R = [ r21 r22 r23 ]
    %     [ r31 r32 r33 ]
    
    theta = acosd((R(1,1)+R(2,2)+R(3,3)-1)/2);
    n = 1/2/sind(theta)*[R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)];    
end