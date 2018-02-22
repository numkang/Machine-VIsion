clear all; clc; close all;

%% Result from 3a)
x = [0; 6; 2];
y = [0; 3; 7];
xy = [x y]';
Xc = 0;
xd = 8;
Yc = 0;
yd = 5;
k = 1.2;
theta = 30;

THETA = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; % transformaiton matrix
P = [(Xc+xd)*ones(1,size(xy,2)); (Yc+yd)*ones(1,size(xy,2))]; % P vector

XY = k*THETA*xy + P; % Calculate the transformed points

%% Sorting the points between an image and a template
% presume that we do not know which point on an image corresponds to which point on a template
for i = 1:length(x)
    j = i+1;
    if j == length(x)+1
        j = 1;
    end
    
    L(i) = sqrt((XY(1,i)-XY(1,j))^2 + (XY(2,i)-XY(2,j))^2); % check length of each side of an image
    l(i) = sqrt((xy(1,i)-xy(1,j))^2 + (xy(2,i)-xy(2,j))^2); % check length of each side of a template 
end

XY_temp = XY;
xy_temp = xy;
for i = 1:length(x)
    % matching the length to each point L1 > L2 > L3 and l1 > l2 > l3
    [~,L_index] = max(L);
    L(L_index) = nan;
    [~,l_index] = max(l);
    l(l_index) = nan;
    
    XY(:,i) = XY_temp(:,L_index);
    xy(:,i) = xy_temp(:,l_index);
end

%% Pseudo Inverse Method
for i = 1:length(x)
    R(2*i-1:2*i, 1) = XY(:,i);
    A(2*i-1:2*i, 1:4) = [xy(1,i) -xy(2,i) 1 0; xy(2,i) xy(1,i) 0 1];
    Q = inv(A'*A)*A'*R;
end

k_3b = round(sqrt(Q(1)^2+Q(2)^2),1);
theta_3b = round(atand(Q(2)/Q(1)));
xd_3b = round(Q(3) - Xc);
yd_3b = round(Q(4) - Yc);

% check whether the results from Pseudo Inverse Method are the same as the given ones
check_equal = [isequal(k,k_3b); isequal(theta,theta_3b); isequal(xd,xd_3b); isequal(yd,yd_3b)]