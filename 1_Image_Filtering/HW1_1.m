clear all; clc; close all;

sR = -1:0.01:1;
p = 1/pi*(acos(sR)-sR.*sqrt(1-sR.^2));

plot(sR,p)
grid on
title('The plot between \rho and s/R');
xlabel('s/R')
ylabel('\rho')