function is_member = membership_test(point, b_hat, B, gamma)
    n = length(point);
    cvx_begin quiet
        variable b(n);
        variable u(n);
        minimize( norm(point - b) );
        b == b_hat + B*u;
        norm(u, Inf) <= gamma;
    cvx_end
    
    if cvx_optval < 0.001
        is_member = 1;
    else
        is_member = 0;
    end
end

