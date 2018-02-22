clear all; clc; close all;

I = imread('nut_shell.jpg'); % read image
I_gray = rgb2gray(I); % change it to grayscale

M = size(I_gray,1); % # of rows I_gray
N = size(I_gray,2); % # of columns I_gray
min_level = double(min(min(I_gray))); % minimum intensity of I_gray
max_level = double(max(max(I_gray))); % maximum intensity of I_gray
thres = [127.5 51 12.75]; % selected values of threshold (over-estimated, appropriated, and under-estimated)

for k = 1:length(thres)
    I_BW(:,:,k) = double(I_gray)-thres(k)*ones(M,N); % seperated between the intensity that higher/lower than threshold
    I_BW(:,:,k) = max(min_level,I_BW(:,:,k)); % change the intensity that lower than the threshold to the minimun intensity
    I_BW(:,:,k) = I_BW(:,:,k)*(max_level)~=(min_level); % change all intensity beside the lowest one to the maximum intensity
end

figure('pos',[0 100 1300 500]);
subplot(2,3,1); imshow(I); title('Original Image');
subplot(2,3,2); imshow(I_gray); title('Grayscale Image');
subplot(2,3,3); histogram(I_gray); title('Histogram');
subplot(2,3,4); imshow(I_BW(:,:,1)); title('Over-Estimated Threshold');
subplot(2,3,5); imshow(I_BW(:,:,2)); title('Appropriated Threshold');
subplot(2,3,6); imshow(I_BW(:,:,3)); title('Under-Estimated Threshold');

%% Using MATLAB Build-IN command

for k = 1:length(thres)
    J_BW(:,:,k) = im2bw(I_gray,thres(k)/max_level);
end

figure('pos',[20 200 1800 500]);
subplot(2,3,1); imshow(I); title('Original Image');
subplot(2,3,2); imshow(I_gray); title('Grayscale Image');
subplot(2,3,3); histogram(I_gray); title('Histogram');
subplot(2,3,4); imshow(J_BW(:,:,1)); title('Over-Estimated Threshold (MATLAB Built-In command)');
subplot(2,3,5); imshow(J_BW(:,:,2)); title('Appropriated Threshold (MATLAB Built-In command)');
subplot(2,3,6); imshow(J_BW(:,:,3)); title('Under-Estimated Threshold (MATLAB Built-In command)');