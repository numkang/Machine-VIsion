clear; clc; close all
load('camera_calibration_data.mat')

%% Find mu
A = [X'.*v' Y'.*v' -X'.*u' -Y'.*u' v'];
b = u';
mu = pinv(A)*b;

%% Find Ty^2
U = sum(mu(1:4).^2);
if mu(1)*mu(4) == mu(2)*mu(3)
    Ty2 = 1/U;
else
    Ty2 = (U-sqrt(U^2-4*(mu(1)*mu(4)-mu(2)*mu(3))^2))/(2*(mu(1)*mu(4)-mu(2)*mu(3))^2);
end

%% Find r13, and r23
r13 = sqrt(1 - Ty2*(mu(1)^2 + mu(2)^2));
r23 = sqrt(1 - Ty2*(mu(3)^2 + mu(4)^2));

%% Check the sign of Ty (alsoobtain r11, r12, r21, r22, and Ty)
Ty = sqrt(Ty2);
r = mu(1:4)*Ty;
Tx = mu(5)*Ty;
ex = r(1)*X(1) + r(2)*Y(1)+ Tx;
ey = r(3)*X(1) + r(4)*Y(1)+ Ty;
if sign(ex) == sign(u(1)) && sign(ey) == sign(v(1))
    % Ty already has the correct sign
else
    Ty = -Ty;
    r = mu(1:4)*Ty;
    Tx = mu(5)*Ty;
end

%% Check the sign of r13, and r23
a = round(r(1)*r(3)+r(2)*r(4));
if sign(a) == 1
    r23 = -r23;
end

%% Construct matrix R
R1 = [r(1) r(2) r13];
R2 = [r(3) r(4) r23];
R = round([R1; R2; cross(R1,R2)],4);

%% % Find f, k, and Tz
r2 = u.^2 + v.^2;
x = R(1,1)*X + R(1,2)*Y + Tx;
AA = [x' (r2.*x)' -u'];
bb = [(R(3,1)*X + R(3,2)*Y).*u]';
xx = round(pinv(AA)*bb,2);
f = xx(1);
Tz = xx(3);
T = [Tx; Ty; Tz];

%% Print the result
f
R
T