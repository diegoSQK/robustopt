function [x,y,z] = simple_robust_opt(A, b_hat, B)
% Inputs:
%   A : Constraint matrix
%   b_hat : Predicted flow requirements
%   B : Uncertainty matrix (b_real = b_hat + Bu)
% Outputs:
%   x,y,z : Decision variables for conservative robust solution

    horizon = length(b_hat);
    b_rob = b_hat + sum(abs(B),2);
    cvx_begin %quiet
        variable x(horizon-1,1);
        variable y(horizon-3,1);
        variable z(horizon,1);
        maximize ( z(horizon) );
        A*[x; y; z] >= b_rob;
        x <= 100;
        x >= 0;
        y >= 0;
        z >= 0;
    cvx_end
end

