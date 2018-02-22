function [h, dh] = Sigmoid(f)
    % Sigmoid Function
    % Return both function value and its derivative value
    h = 1./(1+exp(-f));
    dh = h.*(1-h);
end