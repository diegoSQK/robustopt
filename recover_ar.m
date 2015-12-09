function [Phi, u, gamma] = recover_ar(err_signal,p)
    k = length(err_signal);

    cvx_begin quiet
        variable Phi(k,k) lower_triangular toeplitz;
        minimize( norm(Phi*err_signal - err_signal) );
        diag(Phi) == 0;
        for i = p+2:k
            Phi(i,1) == 0;
        end
    cvx_end

    u = Phi*err_signal - err_signal;
    gamma = max(abs(u));
end

