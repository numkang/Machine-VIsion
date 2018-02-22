clear; clc; close all

XYZ = [-2 -1 0 1 2 3 -2 -1 0 1 2 3 -1 -2 -1 -2 -1 -2 -1 -2; ...
        0  0 0 0 0 0  1  1 1 1 1 1  2  2  3  3  4  4  5  5; ...
        0  0 0 0 0 0  0  0 0 0 0 0  0  0  0  0  0  0  0  0]; % world frame
theta = 135; % rotational angle
Rx = [1 0 0; 0 cosd(theta) sind(theta); 0 -sind(theta) cosd(theta)]; % rotational matrix around x-axis
T = [3; 3.5; 7.5]; % translational matrix
f = 1.3; % focal length

xyz = zeros(size(XYZ,1),size(XYZ,2));
for i = 1:size(xyz,2)
   xyz(:,i) = Rx*XYZ(:,i) + T; % camera frame
end

u = zeros(1,size(XYZ,2));
v = zeros(1,size(XYZ,2));
for i = 1:size(xyz,2)
    u(i) = f*xyz(1,i)/xyz(3,i);
    v(i) = f*xyz(2,i)/xyz(3,i);
end

figure('pos',[0 0 700 900])
subplot(2,1,1)
plot3(XYZ(1,:),XYZ(2,:),XYZ(3,:),'b*', ...
      xyz(1,:),xyz(2,:),xyz(3,:),'r*', ...
      u,v,ones(length(u)),'k*')
xlabel('x')
ylabel('y')
zlabel('z')
title('3D (world) Coordinate')
legend('World Coordinate','Camera Coordinate','Image Coordinate')
grid on
grid minor
view(-75, 63)

subplot(2,1,2)
plot(u,v,'k*')
xlabel('u')
ylabel('v')
title('2D (uv) Coordinate')
legend('Image Coordinate')
grid on
grid minor

X = XYZ(1,:);
Y = XYZ(2,:);
save('camera_calibration_data.mat','X','Y','u','v')
uv = [u' v'];
csvwrite('camera_calibration_data.csv',uv)