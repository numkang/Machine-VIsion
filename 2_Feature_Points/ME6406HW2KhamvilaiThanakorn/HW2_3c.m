clear all; clc; close all;

XY_original = [2 5 5 4 1; 1 2 4 5 3]; % template
xy_original = [9.697 8.566 6.869; 6.96 8.091 5.263]; % target
[xy, l] = sort_triangle(xy_original); % sort target's points
Xc = 0;
Yc = 0;

c = nchoosek(1:size(XY_original,2),3); % combination
for i = 1:size(c,1)
    XY = [XY_original(:,c(i,1)) XY_original(:,c(i,2)) XY_original(:,c(i,3))]; % pick each triangle from the template    
    [XY,L] = sort_triangle(XY); % sort template's points
    for j = 2:3
        e1 = abs(L(2)/L(1) - l(2)/l(1)); % error of imtermediate side of a triangle
        e2 = abs(L(3)/L(1) - l(3)/l(1)); % error of shortest side of a triangle
    end
    e(i) = sqrt(e1^2 + e2^2); % total error
    % Pseudo Inverse Method
    [k(i),theta(i),xd(i),yd(i)] = pseudo_inverse_method(XY, xy, Xc, Yc);
end

[~,best_match_index] = min(e); % find the triangle that has the minimum error
k_best_match = k(best_match_index)
theta_best_match = theta(best_match_index)
xd_best_match = xd(best_match_index)
yd_best_match = yd(best_match_index)

for i = 1:12 % plot the original figure
    if i ~= 2
        subplot(4,3,i)
        plot_HW2_3c(XY_original, xy_original, 'Original');
    end
end

% Forward Transformation in order to check graphically
j = 1;
for i = 1:size(c,1)
        XY = [XY_original(:,c(i,1)) XY_original(:,c(i,2)) XY_original(:,c(i,3))]; % pick each triangle from the template   
        [XY,~] = sort_triangle(XY); % sort template's points
    
        THETA = [cosd(theta(i)) -sind(theta(i)); sind(theta(i)) cosd(theta(i))]; % transformation matrix
        P = [(Xc+xd(i))*ones(1,size(xy,2)); (Yc+yd(i))*ones(1,size(xy,2))]; % P vector
        xy = k(i)*THETA*XY + P; % Calculate the transformed points
     
    if i == best_match_index % subplot the best match figure at top right
        subplot(4,3,3)
        hold on
        plot_HW2_3c(XY, xy, 'Best Match');
    else
        subplot(4,3,3+j) % subplot the others
        hold on
        plot_HW2_3c(XY, xy, i);
        j = j + 1;
    end
end