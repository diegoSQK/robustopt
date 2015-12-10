function B  = uncertainty_ar(Phi,n)
    B = pinv(eye(n)-Phi(1:n,1:n));
end

