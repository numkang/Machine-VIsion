clear all; clc; close all;

I = rgb2gray(imread('blackdot.jpg')); % read image and change to grayscale

%% Using the same Calculation as 3a)
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

G = uint8(round(sqrt(Gx.^2+Gy.^2))); % combine both direction together

%% Using MATLAB Built-IN command with the default threshold
J = edge(I,'Sobel',[],'both');
Jy = edge(I,'Sobel',[],'vertical');
Jx = edge(I,'Sobel',[],'horizontal');

%% Plotting
figure('pos',[0 100 1200 700]);
subplot(3,3,2); imshow(I); title('Original Image');
subplot(3,3,4); imshow(G); title('Same Calculation as 3a)');
subplot(3,3,5); imshow(Gy); title('3a) - Vertical Direction');
subplot(3,3,6); imshow(Gx); title('3a) - Horizontal Direction');
subplot(3,3,7); imshow(J); title('MATLAB built-in command');
subplot(3,3,8); imshow(Jy); title('MATLAB - Vertical Direction');
subplot(3,3,9); imshow(Jx); title('MATLAB - Horizontal Direction');
