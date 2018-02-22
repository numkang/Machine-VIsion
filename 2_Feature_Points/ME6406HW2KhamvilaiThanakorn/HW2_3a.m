clear all; clc; close all;

%% Define all given parameters
x = [0; 6; 2];
y = [0; 3; 7];
xy = [x y]';
Xc = 0;
xd = 8;
Yc = 0;
yd = 5;
k = 1.2;
theta = 30;

THETA = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; % transformation matrix
P = [(Xc+xd)*ones(1,size(xy,2)); (Yc+yd)*ones(1,size(xy,2))]; % P vector

offset = 0.1; % shift the overlaying text
XY = k*THETA*xy + P; % Calculate the transformed points

for i = 1:length(x) % plot them
    j = i+1;
    if j == length(x)+1
        j = 1;
    end
    plot([xy(1,i) xy(1,j)],[xy(2,i) xy(2,j)],'--r*',[XY(1,i) XY(1,j)],[XY(2,i) XY(2,j)],'--b*');
    txt = sprintf('%d, (%d, %d)', i,xy(1,i),xy(2,i));
    text(xy(1,i)+offset, xy(2,i)+offset, txt);
    txt = sprintf('%d, (%.3f, %.3f)', i,XY(1,i),XY(2,i));
    text(XY(1,i)+offset, XY(2,i)+offset, txt);
    hold on
end
axis square
legend('template','transformed','Location','southeast')
xlabel('X')
ylabel('Y')