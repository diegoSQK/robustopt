function [B, u, gamma, Phi] = uncertainty_ar(err_signal,p,n)
% Inputs: 
%   err_signal : Past known error signal
%   p : Desired order of the autoregressive model
%   n : Planning horizon length
% Outputs:
%   B : Matrix encoding the recovered uncertainty set (b_real = b_hat + Bu)
%   u : estimate for uncertainty vector u
%   gamma : estimate for upper bound on uncertainty vector u

    k = length(err_signal);

    cvx_begin quiet
        variable Phi(k,k) lower_triangular toeplitz;
        minimize( norm(Phi*err_signal - err_signal) );
        diag(Phi) == 0;
        for i = p+2:k
            Phi(i,1) == 0;
        end
    cvx_end

    B = inv(eye(n)-Phi(1:n,1:n));
    u = Phi*err_signal - err_signal;
    gamma = max(abs(u));
end

