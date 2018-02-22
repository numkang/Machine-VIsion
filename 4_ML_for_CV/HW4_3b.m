clear; clc; close all
% I(:,:,1) = [3 3 5 6; 3 4 4 5; 4 5 5 6; 4 5 5 6];
% I(:,:,2) = [3 2 3 4; 1 5 3 6; 4 5 3 6; 2 4 4 5];
% I(:,:,3) = [4 2 3 4; 1 4 2 4; 4 3 3 5; 2 3 5 5];
I = imread('fanbone.bmp');

%% Performing PCA
Rr = double(I(:,:,1));
Rg = double(I(:,:,2));
Rb = double(I(:,:,3));
Rr_ = mean(mean(Rr));
Rg_ = mean(mean(Rg));
Rb_ = mean(mean(Rb));

%% 3b-1
C = [covariance(Rr,Rr) covariance(Rr,Rg) covariance(Rr,Rb);
     covariance(Rg,Rr) covariance(Rg,Rg) covariance(Rg,Rb);
     covariance(Rb,Rr) covariance(Rb,Rg) covariance(Rb,Rb)]
 
%% 3b-2
[V,D] = eig(C);
eigenvalue1 = D(3,3)
eigenvalue2 = D(2,2)
eigenvalue3 = D(1,1)
eigenvector1 = V(:,3)
eigenvector2 = V(:,2)
eigenvector3 = V(:,1)

%% 3b-3
A = [V(:,3) V(:,2) V(:,1)]';
X_ = [Rr_; Rg_; Rb_];
for i = 1:size(I,1)
    for j = 1:size(I,2)
        X = [double(I(i,j,1)); double(I(i,j,2)); double(I(i,j,3))];
        X_hat = A*(X - X_);
        Rr_hat(i,j) = X_hat(1);
        Rg_hat(i,j) = X_hat(2);
        Rb_hat(i,j) = X_hat(3);
        
        y = X_ + X_hat.*V(:,3);
        y1(i,j,1) = y(1);
        y1(i,j,2) = y(2);
        y1(i,j,3) = y(3);
        
        y = X_ + X_hat.*V(:,2);
        y2(i,j,1) = y(1);
        y2(i,j,2) = y(2);
        y2(i,j,3) = y(3);
        
        y = X_ + X_hat.*V(:,1);
        y3(i,j,1) = y(1);
        y3(i,j,2) = y(2);
        y3(i,j,3) = y(3);
    end
end
R_hat(:,:,1) = Rr_hat;
R_hat(:,:,2) = Rg_hat;
R_hat(:,:,3) = Rb_hat;

for i = 1:3
    y1(:,:,i) = y1(:,:,i) - min(min(y1(:,:,i)));
    y1(:,:,i) = y1(:,:,i)*255/max(max(y1(:,:,i)));

    y2(:,:,i) = y2(:,:,i) - min(min(y2(:,:,i)));
    y2(:,:,i) = y2(:,:,i)*255/max(max(y2(:,:,i)));

    y3(:,:,i) = y3(:,:,i) - min(min(y3(:,:,i)));
    y3(:,:,i) = y3(:,:,i)*255/max(max(y3(:,:,i)));
end
y11 = y1(:,:,1);
y12 = y1(:,:,2);
y13 = y1(:,:,3);

y21 = y2(:,:,1);
y22 = y2(:,:,2);
y23 = y2(:,:,3);

y31 = y3(:,:,1);
y32 = y3(:,:,2);
y33 = y3(:,:,3);

subplot(3,4,1);
plot(Rr,Rg,'ob')
axis([-300 300 -300 300])
axis square
grid on
grid minor
xlabel('R')
ylabel('G')

subplot(3,4,2);
plot(Rg,Rb,'ob')
axis([-300 300 -300 300])
axis square
grid on
grid minor
xlabel('G')
ylabel('B')

subplot(3,4,3);
plot(Rb,Rr,'ob')
axis([-300 300 -300 300])
axis square
grid on
grid minor
xlabel('B')
ylabel('R')

subplot(3,4,4)
plot3(Rr,Rg,Rb,'bo');
xlabel('R')
ylabel('G')
zlabel('B')
axis equal
grid on
grid minor
axis([-300 300 -300 300 -300 300])

subplot(3,4,5);
plot(Rr_hat,Rg_hat,'or')
axis([-300 300 -300 300])
axis square
grid on
grid minor
xlabel('transformed R')
ylabel('transformed G')

subplot(3,4,6);
plot(Rg_hat,Rb_hat,'or')
axis([-300 300 -300 300])
axis square
grid on
grid minor
xlabel('transformed G')
ylabel('transformed B')

subplot(3,4,7);
plot(Rb_hat,Rr_hat,'or')
axis([-300 300 -300 300])
axis square
grid on
grid minor
xlabel('transformed B')
ylabel('transformed R')

subplot(3,4,8)
plot3(Rr_hat,Rg_hat,Rb_hat,'ro');
xlabel('transformed R')
ylabel('transformed G')
zlabel('transformed B')
axis equal
grid on
grid minor
axis([-300 300 -300 300 -300 300])

subplot(3,4,9)
imShow(Rr_hat)
title('R channel of transformed image')

subplot(3,4,10)
imShow(Rg_hat)
title('G channel of transformed image')

subplot(3,4,11)
imShow(Rb_hat)
title('B channel of transformed image')

subplot(3,4,12)
imshow(R_hat)
title('transformed image')

figure(2)
subplot(2,3,1)
plot3(y11(:),y12(:),y13(:),'ro')
xlabel('R')
ylabel('G')
zlabel('B')
axis equal
grid on
grid minor
% axis([-300 300 -300 300 -300 300])

subplot(2,3,2)
plot3(y21(:),y22(:),y23(:),'go')
xlabel('R')
ylabel('G')
zlabel('B')
axis equal
grid on
grid minor
% axis([-300 300 -300 300 -300 300])

subplot(2,3,3)
plot3(y31(:),y32(:),y33(:),'bo')
xlabel('R')
ylabel('G')
zlabel('B')
axis equal
grid on
grid minor
% axis([-300 300 -300 300 -300 300])

subplot(2,3,4)
imshow(uint8(y1))

subplot(2,3,5)
imshow(uint8(y2))

subplot(2,3,6)
imshow(uint8(y3))