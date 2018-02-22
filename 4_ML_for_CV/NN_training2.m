clear; clc; close all
load('training_data.mat')

% 49 inputs
% 1 hidden layer with 49 nodes
% 4 outputs

y = eye(4); % desired output
% concatenate training sets together
training = [training_M1(:) training_M2(:) training_M3(:) training_M4(:) ...
            training_E1(:) training_E2(:) training_E3(:) training_E4(:) ...
            training_11(:) training_12(:) training_13(:) training_14(:) ...
            training_71(:) training_72(:) training_73(:) training_74(:)];            
        
%% Initialize all weights
alpha = 0.1; % learning rate
phi_1 = rand(49,49);
phi_2 = rand(4,49);
epoch_num = 100;

%% Neural-Network
for num = 1:epoch_num
    sum_error = 0;
    for i = 1:size(training,2)
        
        % Forward Propagation
        a1 = training(:,i);       
        z2 = phi_1*a1;
        [a2, gz2] = Sigmoid(z2);
        z3 = phi_2*a2;
        [a3, ~] = Sigmoid(z3);

        % Backward Propagation
        j = ceil(i/4);
        d3 = a3 - y(:,j);
        d2 = phi_2'*d3.*gz2;
        
        dJ32 = d3*a2';
        dJ21 = d2*a1';
        
        phi_1 = phi_1 - dJ21;
        phi_2 = phi_2 - dJ32;
        
        sum_error = sum_error + sum(d3.^2);
    end
    E(num,1) = 1/2*sum_error;
end
plot(1:epoch_num,E,'-b')
save('NN_weights.mat', 'phi_1', 'phi_2')