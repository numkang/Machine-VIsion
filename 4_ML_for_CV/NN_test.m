clear; clc; close all
load('test_data.mat')
load('NN_weights.mat')

%% Forward Propagation
% Test M
x = test_M(:);   
y_in = w_pj*x;
[y_out, gz2] = Sigmoid(y_in);
z_in = w_qp*y_out;
[z_out, ~] = Sigmoid(z_in);
z_out_M = round(z_out)'

% Test E
x = test_E(:);   
y_in = w_pj*x;
[y_out, gz2] = Sigmoid(y_in);
z_in = w_qp*y_out;
[z_out, ~] = Sigmoid(z_in);
z_out_E = round(z_out)'

% Test 1
x = test_1(:);   
y_in = w_pj*x;
[y_out, gz2] = Sigmoid(y_in);
z_in = w_qp*y_out;
[z_out, ~] = Sigmoid(z_in);
z_out_1 = round(z_out)'

% Test 7
x = test_7(:);   
y_in = w_pj*x;
[y_out, gz2] = Sigmoid(y_in);
z_in = w_qp*y_out;
[z_out, ~] = Sigmoid(z_in);
z_out_7 = round(z_out)'