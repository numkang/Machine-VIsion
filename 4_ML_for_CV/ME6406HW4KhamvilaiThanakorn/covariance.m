function sigma2 = covariance(R1,R2)
    R1_ = mean(mean(R1));
    R2_ = mean(mean(R2));
    c = 0;
    for i = 1:size(R1,1)
        for j = 1:size(R1,2)
            c = c + (R1(i,j) - R1_)*(R2(i,j) - R2_);
        end
    end
    sigma2 = c/numel(R1);
end