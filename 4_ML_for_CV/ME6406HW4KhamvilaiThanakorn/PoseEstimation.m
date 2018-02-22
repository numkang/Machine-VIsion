clear; clc; close all
load('PoseEstimation.mat')

%% Calculate the rotation matrix R and translation matrix T
% Find mu
for i = 1:length(x)
	M(2*i-1:2*i,:) = [f*x(i) f*y(i) f*z(i) 0 0 0 -u(i)*x(i) -u(i)*y(i) -u(i)*z(i) f 0 -u(i);...
                      0 0 0 f*x(i) f*y(i) f*z(i) -v(i)*x(i) -v(i)*y(i) -v(i)*z(i) 0 f -v(i)];
end
% MV = 0 -> using the reduced row echelon technique to solve for V in terms of tz 
rref_M = rref([M zeros(size(M,1),1)]);
% Using the normality constraint to solve for tz
r = -rref_M(1:3,12);
tz = 1/norm(r);
V = round([-rref_M(1:11,12)*tz; tz],4);

R = [V(1:3)'; V(4:6)'; V(7:9)']
T = V(10:12)

%% 2b-1
% 8 Feature Points
XYZ = [x; y; z];
for i = 1:length(x)
    xyz(:,i) = R*XYZ(:,i) + T;
end
xyz

% The Centroid and the Normal Vector
Oo = [0.5; 0.5; 1];
No = [0; 0; 1];
Nc = R*No
Oc = R*Oo + T

plot3(x,y,z,'m*',...
      xyz(1,:),xyz(2,:),xyz(3,:),'r*',...
      Oo(1),Oo(2),Oo(3),'co',...
      Oc(1),Oc(2),Oc(3),'bo',...
      [Oo(1) Oo(1)+No(1)],[Oo(2) Oo(2)+No(2)],[Oo(3) Oo(3)+No(3)],'-c',...
      [Oc(1) Oc(1)+Nc(1)],[Oc(2) Oc(2)+Nc(2)],[Oc(3) Oc(3)+Nc(3)],'-b')
legend('8 feature points in World Coordinate','8 feature points in Camera I Coordinate',...
       'Circle Centroid in World Coordinate','Circle Centroid in Camera I Coordinate',...
       'Normal Vector in World Coordinate','Normal Vector in Camera I Coordinate')
xlabel('x')
ylabel('y')
zlabel('z')
title('3D (world) Coordinate')
grid on
grid minor
axis equal
axis([-5 4 0 1 0 10])

%% 2b-2
Q = [No(1) No(2) No(3) 0 0 0 0 0 0 0 0 0; ...
     0 0 0 No(1) No(2) No(3) 0 0 0 0 0 0; ...
     0 0 0 0 0 0 No(1) No(2) No(3) 0 0 0; ...
     Oo(1) Oo(2) Oo(3) 0 0 0 0 0 0 1 0 0; ...
     0 0 0 Oo(1) Oo(2) Oo(3) 0 0 0 0 1 0; ...
     0 0 0 0 0 0 Oo(1) Oo(2) Oo(3) 0 0 1;];
QQ = [Nc(1)*eye(3) Nc(2)*eye(3) Nc(3)*eye(3) zeros(3)];
W = [M; Q; QQ];
b = [zeros(size(M,1),1); Nc; Oc; No;];
VV = round(inv(W'*W)*W'*b,4);

RR = [VV(1:3)'; VV(4:6)'; VV(7:9)']
TT = VV(10:12)