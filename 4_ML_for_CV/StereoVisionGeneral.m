clear; clc; close all
load('StereoVisionGeneral.mat')

%%
R_1 = Ry1*Rx1;
T_1 = Ry1*T1;
P1 = [f 0 0; 0 f 0; 0 0 1]*[eye(3) zeros(3,1)]*[R_1 T_1; 0 0 0 1];

R_2 = Ry2*Rx2;
T_2 = Ry2*T2;
P2 = [f 0 0; 0 f 0; 0 0 1]*[eye(3) zeros(3,1)]*[R_2 T_2; 0 0 0 1];

for i = 1:length(u1)
    m1 = [u1(i); v1(i); 1];
    m2 = [u2(i); v2(i); 1];
    a1 = skew_matrix(m1)*P1;
    a2 = skew_matrix(m2)*P2;
    A = [a1(1:3,1:3); a2(1:3,1:3)];
    b = [-a1(1:3,4); -a2(1:3,4)]; 
    M(:,i) = round(pinv(A)*b,4);
end
M

plot3(M(1,:),M(2,:),M(3,:),'k*',...
      u1,v1,ones(1,length(u1)),'m*',...
      u2,v2,ones(1,length(u2)),'c*')
legend('World Coordinate','Image I Coordinate','Image II Coordinate')
xlabel('x')
ylabel('y')
zlabel('z')
title('3D (world) Coordinate')
grid on
grid minor
axis equal
axis([-1 2 0 1 0 1])