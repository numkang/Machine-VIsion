clear all; clc; close all;

%% Result Obtained in a.
I = rgb2gray(imread('HW2.jpg')); % read image and change to grayscale
BW = imbinarize(I); % binarized image
[B,~,~,~] = bwboundaries(BW); % find the boundaries
subplot(2,1,1); imshow(I) % show origianl image
hold on
title('Original Image, Boundaries, and Corners');
text(10,10,'\rightarrow y-axis')
text(10,30,'\downarrow')
text(10,50,'x-axis')
for k = 1:length(B) % plot boundaries
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2) % draw a boundaries
end

%% Rho-Theta method
M = size(I,1); % # of rows I
N = size(I,2); % # of columns I

% Center of outer boundary
xc = mean(boundary(:,1)); % x center
yc = mean(boundary(:,2)); % y center
plot(yc,xc,'sg','MarkerSize',10,'MarkerEdgeColor','g','MarkerFaceColor',[0,1,0])

for i = 1:size(boundary,1)
   rho(i) = (sqrt((boundary(i,1) - xc)^2 + (boundary(i,2) - yc)^2))'; % calculate rho
   theta(i) = (atan2d((boundary(i,1) - xc), (boundary(i,2) - yc)))'; % calculate theta
end
subplot(2,1,2); plot(theta,rho,'.') % rho-theta signature
xlabel('\theta');
ylabel('\rho');
title('\rho-\theta signature')
hold on

%% Find the corners
interval = round(range(theta)/6); % divided the rho-theta graph into six intervals
k = 1; % corner index
l = 1;
rho_corners = zeros(6,1);
theta_corners = zeros(6,1);
for i = round(min(theta)):interval:round(max(theta))-interval % move to each interval
    for j = 1:length(theta)
        if theta(j) <= i+interval && theta(j) >= i % consider theta in the interval
            ind1(l) = j;
            l = l + 1;
        end
    end    
    [rho_corners(k), ind2] = max(rho(ind1)); % maximum rho in each interval
    theta_corners(k) = theta(ind1(ind2)); % theta at the maximum rho
    plot(theta_corners(k),rho_corners(k),'sr','MarkerSize',5,'MarkerEdgeColor','r','MarkerFaceColor',[1,0,0]) % plot
    txt = sprintf('(%.1f, %.1f)', theta_corners(k),rho_corners(k));
    text(theta_corners(k),rho_corners(k), txt, 'color', 'k');
    k = k + 1;
    l = 1; % reset index of each interval
    clear ind1
end

%% Plot corners on the image
subplot(2,1,1)
hold on
for i = 1:length(rho_corners) % change rho-theta back to x-y
   x(i) = rho_corners(i)*sind(theta_corners(i)) + xc; 
   y(i) = rho_corners(i)*cosd(theta_corners(i)) + yc;
   
   txt = sprintf('(%.0f, %.0f)', x(i),y(i));
   text(y(i)-15, x(i)+15, txt, 'color', 'w');
end
plot(y,x,'sr','MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor',[1,0,0]) % plot