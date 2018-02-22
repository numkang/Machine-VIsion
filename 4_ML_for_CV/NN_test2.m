clear; clc; close all
load('test_data.mat')
load('training_data.mat')
load('NN_weights.mat')

%% Forward Propagation
a1 = test_E(:);       
z2 = phi_1*a1;
[a2, gz2] = Sigmoid(z2);
z3 = phi_2*a2;
[a3, gz3] = Sigmoid(z3);