clear; clc; close all

%% coefficient from a given equation
A = 4
B = 0
C = 1
D = -4
E = -1
F = -11
f = 0.1;

%% solve for alpha and beta
syms a b r
[alpha, beta] = solve(A+F*a*a/f/f+2*D*a/f == C+F*b*b/f/f+2*E*b/f,... 
                      B+F*a*b/f/f+D*b/f+E*a/f == 0);
alpha = double(alpha)
beta = double(beta)

%% plug in the obtained alpha and beta
AA = A+F*alpha.*alpha/f/f+2*D*alpha/f;
CC = C+F*beta.*beta/f/f+2*E*beta/f;
round(AA,4) == round(CC,4) % check if the coefficient of x_c^2 == y_c^2
DD = (F*alpha/f/f+D/f);
EE = (F*beta/f/f+E/f);
FF = (F/f/f);

%% Divide the whole equation by either AA or CC
DD = (F*alpha/f/f+D/f)./CC;
EE = (F*beta/f/f+E/f)./CC;
FF = (F/f/f)./CC;

%% solve for gamma
gamma = 1./sqrt(round(-FF + EE.^2 + DD.^2))

%% plug in the obtained gamma
DDD = DD.*gamma;
EEE = EE.*gamma;
FFF = FF.*gamma.*gamma;
-FFF+DDD.^2+EEE.^2 % check if the radius is equal to 1

%% Find the center and plane equation
xc = -DDD
yc = -EEE
zc = alpha.*xc+beta.*yc+gamma