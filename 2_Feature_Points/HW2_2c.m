clear all; clc; close all;

%% Result Obtained in a. with Guassian Filter
I = rgb2gray(imread('HW2.jpg')); % read image and change to grayscale
BW = imbinarize(I); % binarized image
[B,~,~,~] = bwboundaries(BW); % find the boundaries
subplot(2,1,1); 
imshow(I) % show origianl image
hold on
title('Original Image, Boundaries, Lines, and Corners');
text(10,10,'\rightarrow y-axis')
text(10,30,'\downarrow')
text(10,50,'x-axis')
for k = 1:length(B) % plot boundaries
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2) % draw a boundaries
end

%% Curvature Method
x = boundary(:,1); % x boundary
y = boundary(:,2); % y boundary
sigma = 4; % Gaussian Co-variance
mask_size = 3*sigma*2 + 1; % Gaussian Mask Size
L = floor(mask_size/2);
for i = 1:mask_size % create Line Gaussian Filter
    G(i) = 1/(sigma*sqrt(2*pi))*exp((-(i-L-1)^2)/(2*sigma^2));
end

for i = 1+L:length(x)-L % Convolution Integral   
    X(i-L,1) = sum(x(i-L:i+L)'.*G); % Convolution Integral in x-direction
    Y(i-L,1) = sum(y(i-L:i+L)'.*G); % Convolution Integral in y-direction
end
% enclose the boundary
X = [X; X(1)];
Y = [Y; Y(1)];

%% Find the Derivative and K by using Central Difference
for i = 1:length(X) % j: previous point, k: next point
    if i == 1
        j = length(X); % The last point is the previous point of the first one
        k = i + 1;
    elseif i == length(X)
        j = i - 1;
        k = 1; % The first point is the next point of the last one
    else
        j = i - 1;
        k = i + 1;
    end
    
    xd(i,1) = (X(k)-X(j))/2; % 1st order central difference
    xdd(i,1) = X(k)-2*X(i)+X(j); % 2nd order central difference
    yd(i,1) = (Y(k)-Y(j))/2; % 1st order central difference
    ydd(i,1) = Y(k)-2*Y(i)+Y(j); % 2nd order central difference
    den(i,1) = ((xd(i,1)^2+yd(i,1)^2)^(3/2)); % denominator
    K(i,1) = (xd(i,1)*ydd(i,1) - yd(i,1)*xdd(i,1))/den(i,1); % Calculate K
end
subplot(2,1,2);
plot(K);
hold on
xlabel('Points');
ylabel('K');

%% Find the corners
j = 1;
interval = round(length(K)/6); % divided K graph into six intervals
for i = 1:interval:length(K)-interval
    [~,ind(j)] = max(abs(K(i:i+interval))); % maximum absolute K
    ind(j) = ind(j) + (j-1)*interval; % index of max abs K in each interval
    txt = sprintf('(%.1f, %.1f)', ind(j),K(ind(j)));
    text(ind(j),K(ind(j)), txt, 'color', 'k');
    j = j + 1;
end
plot(ind,K(ind),'sr','MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor',[1,0,0])

subplot(2,1,1) % Plot corners on the original image
hold on
plot(y(ind),x(ind),'sr','MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor',[1,0,0])
for i = 1:length(ind)
   txt = sprintf('(%.0f, %.0f)', x(ind(i)),y(ind(i)));
   text(y(ind(i))-15, x(ind(i))+15, txt, 'color', 'w');
end