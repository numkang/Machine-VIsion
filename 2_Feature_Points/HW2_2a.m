clear all; clc; close all;

I = rgb2gray(imread('HW2.jpg')); % read image and change to grayscale
BW = imbinarize(I); % binarized image
[B,~,~,~] = bwboundaries(BW); % find the boundaries
imshow(I)
hold on
text(10,10,'\rightarrow y-axis')
text(10,20,'\downarrow')
text(10,30,'x-axis')
for k = 1:length(B) % plot boundaries
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end