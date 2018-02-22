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
alpha = 0.1; % learning rate
w_pj = rand(49,49)*1;
w_qp = rand(4,49)*1;
epoch_num = 100;

%% Neural-Network
for num = 1:epoch_num
    sum_error = 0;
    for i = 1:size(training,2)
        
        % Forward Propagation
        x = training(:,i);
        y_in = w_pj*x;
        [y_out, dh_y_in] = Sigmoid(y_in);
        z_in = w_qp*y_out;
        [z_out, dh_z_in] = Sigmoid(z_in);

        % Backward Propagation
        j = ceil(i/4);
        error = r(:,j) - z_out;
        dq = error;%.*dh_z_in;
        dp = w_qp'*dq;%.*dh_y_in;
        
        d_w_qp = alpha*dq*y_out';
        d_w_pj = alpha*dp*x';
        
        w_pj = w_pj + d_w_pj;
        w_qp = w_qp + d_w_qp;
        
%         aa1 = training_E3(:);
%         zz2 = w_pj*aa1;
%         [aa2, gzz2] = Sigmoid(zz2);
%         zz3 = w_qp*aa2;
%         [aa3, ~] = Sigmoid(zz3);
        
        sum_error = sum_error + sum(error.^2);        
    end
    E(num,1) = 1/length(x)*sum_error;
end

save('NN_weights.mat', 'w_pj', 'w_qp')
% NN_test3
plot(1:epoch_num,E,'-b')
title('Mean Squared Error vs. Numver of Epoch')
ylabel('J')
xlabel('N')
grid on
grid minor