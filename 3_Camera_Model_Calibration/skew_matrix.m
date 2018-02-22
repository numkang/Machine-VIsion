function skew_P = skew_matrix(P)
    % Generate the skew matrix from a given vector    
    skew_P = [0 -P(3) P(2); P(3) 0 -P(1); -P(2) P(1) 0];
end