clear all; clc; close all;

I = imread('teeth.jpg');
%% Using the codes from 2a
n = 8;
M = size(I,1);
N = size(I,2);
min_level = double(min(min(I)));
max_level = double(max(max(I)));

h = zeros(max_level-min_level+1,1);
for i = 1:M
    for j = 1:N
        h(I(i,j)-min_level+1) = h(I(i,j)-min_level+1) + 1;
    end
end

cdf = h;
for i = 2:length(h)
   cdf(i) = cdf(i-1)+h(i);
end

q = (2^n-1)/(M*N).*cdf;
q_round = round(q);

for i = 1:M
    for j = 1:N
        I_eq(i,j) = uint8(q_round(uint8(I(i,j))+1));
    end
end

h_eq = zeros(max_level-min_level+1,1);
for i = 1:M
    for j = 1:N
        h_eq(I_eq(i,j)-min_level+1) = h_eq(I_eq(i,j)-min_level+1) + 1;
    end
end

level = min_level:max_level;

figure('pos',[0 100 1300 500]);
subplot(2,4,1); imshow(I,[min_level,max_level]); 
title('Original Image')
subplot(2,4,2); imshow(I_eq,[min_level,max_level]); 
title('Histogram Equalized Image')
subplot(2,4,5); bar(level,h); axis([-10 300 0 40000]);
title('codes from 2a')
xlabel('level'); ylabel('# of pixels')
subplot(2,4,6); bar(level,h_eq); axis([-10 300 0 40000]);
title('codes from 2a')
xlabel('level'); ylabel('# of pixels')

%% Using MATLAB built-in commands
subplot(2,4,3); imshow(I,[min_level,max_level]); 
title('Original Image')
subplot(2,4,4); histeq(I);
title('Histogram Equalized Image')
subplot(2,4,7); histogram(I,2^n);
title('MATLAB built-in'); axis([-10 300 0 40000]);
xlabel('level'); ylabel('# of pixels')
subplot(2,4,8); histogram(histeq(I),2^n);
title('MATLAB built-in')
xlabel('level'); ylabel('# of pixels')

%% Error between the codes from 2a and MATLAB built-in commands
err = double(I_eq)-double(histeq(I));