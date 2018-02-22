clear; clc; close all

XYZ = [ 0 1 1 0 0 1 1 0; ...
        0 0 1 1 0 0 1 1; ...
        0 0 0 0 1 1 1 1]; % world frame
    
% Camera I
thetax1 = 180; % rotational angle
thetay1 = -40;
Rx1 = [1 0 0; 0 cosd(thetax1) -sind(thetax1); 0 sind(thetax1) cosd(thetax1)]; % rotational matrix around x-axis
T1 = [2; 1; 8]; % translational matrix
f1 = 1.3; % focal length

% Camera II
thetax2 = 180; % rotational angle
thetay2 = 40;
Rx2 = [1 0 0; 0 cosd(thetax2) -sind(thetax2); 0 sind(thetax2) cosd(thetax2)]; % rotational matrix around x-axis
T2 = [-2; 1; 8]; % translational matrix
f2 = 1.3; % focal length

xyz1 = zeros(size(XYZ,1),size(XYZ,2));
xyz2 = zeros(size(XYZ,1),size(XYZ,2));
for i = 1:size(xyz1,2)
   xyz1(:,i) = Rx1*XYZ(:,i) + T1; % camera I frame
   xyz2(:,i) = Rx2*XYZ(:,i) + T2; % camera II frame
end

u1 = zeros(1,size(XYZ,2));
v1 = zeros(1,size(XYZ,2));

u2 = zeros(1,size(XYZ,2));
v2 = zeros(1,size(XYZ,2));

for i = 1:size(xyz1,2)
    u1(i) = f1*xyz1(1,i)/xyz1(3,i);
    v1(i) = f1*xyz1(2,i)/xyz1(3,i);
    
    u2(i) = f2*xyz2(1,i)/xyz2(3,i);
    v2(i) = f2*xyz2(2,i)/xyz2(3,i);
end

subplot(2,2,1:2)
plot3(XYZ(1,:),XYZ(2,:),XYZ(3,:),'k*',...
      xyz1(1,:),xyz1(2,:),xyz1(3,:),'r*',...
      u1,v1,ones(1,length(u1)),'m*',...
      xyz2(1,:),xyz2(2,:),xyz2(3,:),'b*',...
      u2,v2,ones(1,length(u2)),'c*')
legend('World Coordinate','Camera I Coordinate','Image I Coordinate','Camera II Coordinate','Image II Coordinate')
xlabel('x')
ylabel('y')
zlabel('z')
title('3D (world) Coordinate')
grid on
grid minor
axis equal
axis([-8 8 0 1 0 10])

subplot(2,2,3)
plot(u1,v1,'m*')
xlabel('u1')
ylabel('v1')
title('2D (u1,v1) Coordinate')
legend('Image I Coordinate','Location','Best')
grid on
grid minor
axis square
% axis([-2 2 -0.1 0.3])

subplot(2,2,4)
plot(u2,v2,'c*')
xlabel('u2')
ylabel('v2')
title('2D (u2,v2) Coordinate')
legend('Image II Coordinate','Location','Best')
grid on
grid minor
axis square
% axis([-2 2 -0.1 0.3])

%% Calculating depth Z
b = mean(abs(xyz1(1,:) - xyz2(1,:)));
d = round(u1,6) - round(u2,6);
Z = b*f1./d %f1 = f2