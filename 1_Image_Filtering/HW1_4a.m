clear all; clc; close all;

I = imread('nut_shell.jpg');
I_gray = rgb2gray(I);
I_BW1 = im2bw(I_gray,0.5);
I_BW2 = im2bw(I_gray,0.2);
I_BW3 = im2bw(I_gray,0.05);

subplot(2,3,1); imshow(I); title('Original Image');
subplot(2,3,2); imshow(I_gray); title('Grayscale Image');
subplot(2,3,3); histogram(I_gray); title('Histogram');
subplot(2,3,4); imshow(I_BW1); title('Over-Estimated Threshold');
subplot(2,3,5); imshow(I_BW2); title('Appropriated Threshold');
subplot(2,3,6); imshow(I_BW3); title('Under-Estimated Threshold');