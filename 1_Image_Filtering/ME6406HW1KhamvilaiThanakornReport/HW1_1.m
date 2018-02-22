clear all; clc; close all;

sR = -1:0.01:1; % set a length of s/R to be [-1:1] since -R <= s <= R
p = 1/pi*(acos(sR)-sR.*sqrt(1-sR.^2)); %equation for p that has been proved

plot(sR,p)
grid on
title('The plot between \rho and s/R');
xlabel('s/R')
ylabel('\rho')