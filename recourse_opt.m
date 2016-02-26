function [x, X, optval] = recourse_opt(c, A, b_hat, b_real, B, gamma)
% Inputs:
%   c : Linear objective coefficients
%   A : Constraint matrix
%   b_hat : Predicted requirements
%   b_real : True requirements, used to evaluate performance
%   gamma : Bound on uncertainty
%   B : Uncertainty matrix (b_real = b_hat + Bu)
% Outputs:
%   x,X : Decision variables and recourse matrix
%   optval : Achieved objective value after revealed uncertainty

    horizon = length(b_hat);
    num_var = length(c);

    cvx_begin quiet
        variable x(num_var,1);
        variable X(num_var, horizon) lower_triangular;
        maximize ( c'*( x - gamma*sum(abs(X),2)) );
        A*x >= b_hat + gamma*sum(abs(A*X-B),2);
        diag(X) == 0;
    cvx_end
    
    u = inv(B)*(b_real - b_hat);
    optval = c*(x + X*u);
end
