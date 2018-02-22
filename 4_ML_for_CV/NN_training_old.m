clear; clc; close all
load('training_data.mat')

% 49 inputs
% 1 hidden layer with 49 nodes
% 4 outputs

r = eye(4); % desired output
% concatenate training sets together
training = [training_M1(:) training_M2(:) training_M3(:) training_M4(:) ...
            training_E1(:) training_E2(:) training_E3(:) training_E4(:) ...
            training_11(:) training_12(:) training_13(:) training_14(:) ...
            training_71(:) training_72(:) training_73(:) training_74(:)];            
        
%% Initialize all weights
alpha = 1; % learning rate
% load('NN_weights.mat')
w_qp = 0.1*ones(4,49);
w_pj = 0.1*ones(49,49);
epoch_num = 100;

%% Neural-Network
for num = 1:epoch_num
    sum_error = 0;
    for i = 13:16%size(training,2)
        x_in = training(:,i);
        
        % Forward Propagation
        [x_out,~] = Sigmoid(x_in);
        y_in = w_pj*x_out;
        [y_out,~] = Sigmoid(y_in);
        z_in = w_qp*y_out;
        [z_out,~] = Sigmoid(z_in);

        % Backward Propagation
        [~, dh] = Sigmoid(z_in);
        j = ceil(i/4);
        error = r(:,j)-z_out;
        d_q = error.*dh;
        d_w_qp = alpha*d_q*y_out';

        d_p = w_qp'*d_q;
        d_w_pj = alpha*d_p*x_out';

        w_qp = w_qp + d_w_qp;
        w_pj = w_pj + d_w_pj;
        
        sum_error = sum_error + sum(error.^2);
    end
    E(num,1) = 1/2*sum_error;
end

save('NN_weights.mat', 'w_qp', 'w_pj')