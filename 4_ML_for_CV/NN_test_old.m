clear; clc; close all
load('test_data.mat')
load('NN_weights.mat')

x_in = test_M(:);

%% Forward Propagation
[x_out,~] = Sigmoid(x_in);
y_in = w_pj*x_out;
[y_out,~] = Sigmoid(y_in);
z_in = w_qp*y_out;
[z_out,~] = Sigmoid(z_in);