function [B, u, gamma, Phi, Theta] = uncertainty_arma(err_signal,u,p,q,n)
% Inputs: 
%   err_signal : Past known error signal
%   p : Desired order of the autoregressive model
%   n : Planning horizon length
% Outputs:
%   B : Matrix encoding the recovered uncertainty set (b_real = b_hat + Bu)
%   u : estimate for uncertainty vector u
%   gamma : estimate for upper bound on uncertainty vector u

    k = length(err_signal);
    rho = 0.0005;

    cvx_begin quiet
        variable Phi(k,k) lower_triangular toeplitz;
        variable Theta(k,k) lower_triangular toeplitz;
        %TODO: add regularization parameter
        minimize( norm(Phi*err_signal + Theta*u - err_signal) + rho*norm(Theta, 'fro') );
        diag(Phi) == 0;
        diag(Theta) == 0;
        for i = p+2:k
            Phi(i,1) == 0;
        end
        for j = q+2:k
            Theta(j,1) == 0;
        end
    cvx_end

    B = inv(eye(n) - Phi(1:n,1:n))*(eye(n) + Theta(1:n,1:n));
    u = Phi*err_signal + Theta*u - err_signal;
    gamma = max(abs(u));
end


