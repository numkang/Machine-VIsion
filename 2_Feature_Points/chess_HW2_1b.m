clear all; clc; close all;

I = rgb2gray(imread('chess.jpg')); % read image and change to grayscale

%% Using the same Calculation as 3a)
% [Gy, Gx, G] = edge_Sobel(I);
[Gx, Gy] = imgradientxy(I);
M = size(I,1); % # of rows I
N = size(I,2); % # of columns I
k = 1;
for i = 1:N
    for j = 1:M
       v = ((i-1)*Gx(j,i)+(j-1)*Gy(j,i))/(Gx(j,i)^2+Gy(j,i)^2);
        if ~isnan(v)
            x0(k,:) = round(v*Gx(j,i));
            y0(k,:) = round(v*Gy(j,i));
            k = k+1;
        end
    end
end

c = zeros(range(y0)+1,range(x0)+1);
for i = 1:k-1
    if y0(i) ~= 0 && x0(i) ~= 0
        c(y0(i)-min(y0)+1,x0(i)-min(x0)+1) = c(y0(i)-min(y0)+1,x0(i)-min(x0)+1) + 1;
    end
end

[max_c,ind] = max(c(:));
[ind1,ind2] = ind2sub(size(c),ind);
y00 = min(y0)+ind1-1;
x00 = min(x0)+ind2-1;

% xx = (min(x0):max(x0))';
% yy = (min(y0):max(y0))';
% [X,Y] = meshgrid(min(x0):max(x0),min(y0):max(y0));
% cc = c;
% cc(cc==0) = nan;
% surf(X,Y,cc,gradient(cc))

figure(2)
imshow(I);
hold on
x = (1:N)';
y = y00 - x00/y00*(x - x00);
plot(x,y,'LineWidth',4)
