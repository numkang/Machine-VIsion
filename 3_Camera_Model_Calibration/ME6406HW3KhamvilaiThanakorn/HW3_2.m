clear; clc; close all
load('robot_hand_eye_data.mat')

%% sub problem 1

% Hcij = Hcj*inv(Hci)
Hc12 = Hc2*inv(Hc1);
Hc23 = Hc3*inv(Hc2);

disp('Results of the sub-problem 1')

% Hcij = [   R   T ]
%        [ 0 0 0 1 ]
Rc12 = Hc12(1:3,1:3)
Tc12 = Hc12(1:3,4)

Rc23 = Hc23(1:3,1:3)
Tc23 = Hc23(1:3,4)

%% sub problem 2

% Hgij = [   R   T ]
%        [ 0 0 0 1 ]
Rg12 = Hg12(1:3,1:3);
Tg12 = Hg12(1:3,4);

Rg23 = Hg23(1:3,1:3);
Tg23 = Hg23(1:3,4);

disp('Results of sub-problem 2')

[nc12, thetac12] = find_n_theta_from_R(Rc12)
[nc23, thetac23] = find_n_theta_from_R(Rc23)
[ng12, thetag12] = find_n_theta_from_R(Rg12)
[ng23, thetag23] = find_n_theta_from_R(Rg23)

%% sub problem 3

disp('Results of sub-problem 3')

% Pr = 2*sin(theta/2)*[n1; n2; n3]
Pc12 = 2*sind(thetac12/2)*nc12
Pc23 = 2*sind(thetac23/2)*nc23
Pg12 = 2*sind(thetag12/2)*ng12
Pg23 = 2*sind(thetag23/2)*ng23

disp('Check R using equation (8) in ref[2]')

% Using equation (8) in ref[2] to check R
Rc12_8 = find_R_from_n_and_theta(nc12, thetac12);
Rc23_8 = find_R_from_n_and_theta(nc23, thetac23);
Rg12_8 = find_R_from_n_and_theta(ng12, thetag12);
Rg23_8 = find_R_from_n_and_theta(ng23, thetag23);

round(Rc12_8,4) == round(Rc12,4)
round(Rc23_8,4) == round(Rc23,4)
round(Rg12_8,4) == round(Rg12,4)
round(Rg23_8,4) == round(Rg23,4)

disp('Check R using equation (10) in ref[2]')

% Using equation (10) in ref[2] to check R
Rc12_10 = find_R_from_P(Pc12);
Rc23_10 = find_R_from_P(Pc23);
Rg12_10 = find_R_from_P(Pg12);
Rg23_10 = find_R_from_P(Pg23);

round(Rc12_10,4) == round(Rc12,4)
round(Rc23_10,4) == round(Rc23,4)
round(Rg12_10,4) == round(Rg12,4)
round(Rg23_10,4) == round(Rg23,4)

%% sub problem 4

disp('Results of sub-problem 4')

% compute P'cg (Pcg_)
skew_Pg12_Pc12 = skew_matrix(Pg12+Pc12);
Pc12_Pg12 = Pc12 - Pg12;
skew_Pg23_Pc23 = skew_matrix(Pg23+Pc23);
Pc23_Pg23 = Pc23 - Pg23;

% set up a linear least square equation Ax = B
A = [skew_Pg12_Pc12; skew_Pg23_Pc23];
B = [Pc12_Pg12; Pc23_Pg23];
Pcg_ = pinv(A)*B;

% compute theta_Rgc
theta_Rgc = 2*atand(norm(Pcg_));

% compute Pcg and Rcg
Pcg = 2*Pcg_/(sqrt(1+norm(Pcg_)^2))
Rcg = find_R_from_P(Pcg)

% compute Tcg
Rg12_I = Rg12 - eye(3);
Rcg_Tc12_Tg12 = Rcg*Tc12-Tg12;
Rg23_I = Rg23 - eye(3);
Rcg_Tc23_Tg23 = Rcg*Tc23-Tg23;

% set up a linear least square equation Ax = B
AA = [Rg12_I; Rg23_I];
BB = [Rcg_Tc12_Tg12; Rcg_Tc23_Tg23];
Tcg = pinv(AA)*BB