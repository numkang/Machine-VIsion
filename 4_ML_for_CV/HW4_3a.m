clear; clc; close all
I = imread('fanbone.bmp');
subplot(2,2,1);
imshow(I);
title('Original Image');

%% Performing ACC
fj = double(I(:,:,1));
fk = -(double(I(:,:,1)) - double(I(:,:,3)));

sigma_c = 4;
sigma_s = 4;

% Distributive Property of the Convolution Integral
DoG = Gaussian_Filter(fj, sigma_c) - Gaussian_Filter(fj, sigma_s);
Gs = Gaussian_Filter(fj - fk, sigma_s);

h = DoG + Gs;
subplot(2,2,2);
imShow(h)
title('ACC Filtered Image')

%% Applying Threshold to filter out everything but fanbone
thres1 = 160;
thres2 = 200;
for i = 1:size(h,1)
    for j = 1:size(h,2)
        if h(i,j) <= thres1 || h(i,j) >= thres2
            h(i,j) = 0;
        else
            h(i,j) = 255;
        end
    end
end
h = uint8(h);
subplot(2,2,3);
imshow(h)
title('Binarized Threshold Image')

%% Removing Boundaries
[B,~,~,~] = bwboundaries(h);
subplot(2,2,4);
imshow(h)
hold on
boundary = B{1};
plot(boundary(:,2), boundary(:,1), '-k', 'LineWidth', 3)
boundary = B{3};
plot(boundary(:,2), boundary(:,1), '-k', 'LineWidth', 3)
title('Binarized Threshold Image - Removed Boundary')