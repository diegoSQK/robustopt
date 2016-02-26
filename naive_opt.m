function [x, optval] = naive_opt(c, A, b_hat)
% Inputs
%   A : Constraint matrix
%   c : Linear objective coefficients
%   b_hat : Predicted requirements
% Outputs:
%   x : Optimal decision variables (assuming no prediction error)
%   optval : Optimal objective value

    var_num = length(c);
    cvx_begin quiet
        variable x(var_num,1);
        maximize ( c'*x );
        A*x >= b_hat;
    cvx_end
    
    optval = cvx_optval;
end
