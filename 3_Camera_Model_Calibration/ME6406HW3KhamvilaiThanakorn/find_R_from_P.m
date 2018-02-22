function R = find_R_from_P(P)
    % Calculate a rotational matrix R from a given vector P 
    % R = (1 - abs(P)^2/2)*I + 1/2*(P*P'+a*skew(P))
    % where a = sqrt(4 - abs(P)^2)
    
    a = sqrt(4 - norm(P)^2);
    skew_P = [0 -P(3) P(2); P(3) 0 -P(1); -P(2) P(1) 0];
    R = (1 - norm(P)^2/2)*eye(3) + 1/2*(P*P'+a*skew_P);

end