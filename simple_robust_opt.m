function [x,optval] = simple_robust_opt(A, b_hat, B, gamma)
% Inputs:
%   c : Linear objective coeefficients
%   A : Constraint matrix
%   b_hat : Predicted flow requirements
%   B : Uncertainty matrix (b_real = b_hat + Bu)
%   gamma : Bound on uncertainty
% Outputs:
%   x : Decision variables for conservative robust solution

    var_num = length(c);

    cvx_begin quiet
        variable x(var_num,1);
        maximize ( c'*x );
        A*x >= b_hat + gamma*sum(abs(B),2);
    cvx_end
    
    wealth = cvx_optval;
end

