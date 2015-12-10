function B = uncertainty_arma(Phi, Theta, n)
    B = pinv(eye(n) - Phi(1:n,1:n))*(eye(n) + Theta(1:n,1:n));
end

