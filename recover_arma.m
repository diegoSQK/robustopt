function [Phi, Theta, u, gamma] = recover_arma(err_signal, p, q)
    k = length(err_signal);
    s = 3*(p+q); 
    [~, u, ~] = recover_ar(err_signal,s);
    
    for iter = 1:50
        cvx_begin quiet
            variable Phi(k,k) lower_triangular toeplitz;
            variable Theta(k,k) lower_triangular toeplitz;
            minimize( norm(Phi*err_signal + Theta*u - err_signal) );
            diag(Phi) == 0;
            diag(Theta) == 0;
            for i = p+2:k
                Phi(i,1) == 0;
            end
            for j = q+2:k
                Theta(j,1) == 0;
            end
        cvx_end

        u_new = pinv(eye(k) + Theta)*(eye(k) - Phi)*err_signal;
        diff = max(abs(u - u_new));
        if diff < 0.001
            break;
        end
        u = u_new;
    end

    gamma = max(abs(u));
end


