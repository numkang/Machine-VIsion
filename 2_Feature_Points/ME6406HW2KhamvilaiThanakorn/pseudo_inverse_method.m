function [k,theta,xd,yd] = pseudo_inverse_method(xy, XY, Xc, Yc)
    % Pseudo Inverse Method
    % Input: template (xy), Image (XY), Image Center (Xc,Yc)
    % Output: scale (k), orientation (theta), position (xd,yd)
    
    for i = 1:size(xy,2)
        R(2*i-1:2*i, 1) = XY(:,i);
        A(2*i-1:2*i, 1:4) = [xy(1,i) -xy(2,i) 1 0; xy(2,i) xy(1,i) 0 1];
        Q = pinv(A)*R;
    end

    k = round(sqrt(Q(1)^2+Q(2)^2),1);
    theta = round(atand(Q(2)/Q(1)));
    xd = round(Q(3) - Xc);
    yd = round(Q(4) - Yc);
end