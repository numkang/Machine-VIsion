clear; clc; close all
% I_RGB = imread('Untitled.png');
I_RGB = imread('fanbone.bmp');
cform = makecform('srgb2lab');
I_Lab = applycform(I_RGB,cform);
subplot(2,2,1);
imshow(I_RGB);
title('Original Image')

%% Performing K-means Clustering
K = 3; % Cluster Number

% Vectorize the training set
l = 1;
for i = 1:size(I_Lab,1)
    for j = 1:size(I_Lab,2)
        X_Lab(:,l) = [double(I_Lab(i,j,1)); double(I_Lab(i,j,2)); double(I_Lab(i,j,3))];
        X(:,l) = [double(I_Lab(i,j,2)); double(I_Lab(i,j,3))];
        l = l + 1;
    end
end
subplot(2,2,2);
plot3(X_Lab(1,:),X_Lab(2,:),X_Lab(3,:),'ob')
grid on
grid minor
axis square
title('L-a-b Coordinate System')
xlabel('L')
ylabel('a')
zlabel('b')

% randomly initialize cluster centroids
rand_ind = randperm(l-1,K);
mu = X(:,rand_ind);
error = 100;

% K-means Clustering
while error > 0.01
    for i = 1:l-1
        for k = 1:K
            C(k) = norm(X(:,i) - mu(:,k));
        end
        [~,ind] = min(C);
        c(i) = ind;
    end

    sum_cx = zeros(size(X,1),K);
    sum_c = zeros(size(X,1),K);
    for i = 1:l-1
        for k = 1:K
            if c(i) == k
                sum_cx(:,k) = sum_cx(:,k) + c(i)*X(:,i);
                sum_c(:,k) = sum_c(:,k) + c(i);
            end
        end    
    end
    mu_old = mu;
    mu = sum_cx./sum_c;
    error = norm(mu - mu_old);
end

% Check Cost Function
% J = 0;
% for i = 1:l-1
% 	for k = 1:K
%       if c(i) == k
%           j = norm(X(:,i) - mu(:,k));
%       end
%   end
%   J = J + j;
% end
% J
% rand_ind
% mu

%% Pick each cluster to plot
x1 = 1;
x2 = 1;
x3 = 1;
for i = 1:l-1
    if c(i) == 1
    	X1(:,x1) = X(:,i);
        x1 = x1 + 1;
    elseif c(i) == 2
    	X2(:,x2) = X(:,i);
    	x2 = x2 + 1;
    elseif c(i) == 3
    	X3(:,x3) = X(:,i);
    	x3 = x3 + 1;
    end
end

subplot(2,2,3)
plot(X1(1,:),X1(2,:),'*b',mu(1,1),mu(2,1),'xk');
hold on
plot(X2(1,:),X2(2,:),'*g',mu(1,2),mu(2,2),'xk');
plot(X3(1,:),X3(2,:),'*y',mu(1,3),mu(2,3),'xk');
hold off
grid on
grid minor
axis square
title('K-means Clustering on a-b Domain')
xlabel('a')
ylabel('b')

%% Connected-Component Labeling on Objects
subplot(2,2,4)
cc = flip(imrotate(reshape(c,[size(I_Lab,2),size(I_Lab,1)]),-90),2);
imShow(cc)
title('Connected-Component Labeling')