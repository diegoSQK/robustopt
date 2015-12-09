function [x,y,z,wealth] = naive_opt(A, b_hat)
% Inputs:
%   A : Constraint matrix
%   b_hat : Predicted flow requirements
% Outputs:
%   x, y, z : Optimal decision variables (assuming no prediction error)

    horizon = length(b_hat);
    cvx_begin quiet
        variable x(horizon-1,1);
        variable y(horizon-3,1);
        variable z(horizon,1);
        maximize ( z(horizon) );
        A*[x; y; z] == b_hat;
        x <= 100;
        x >= 0;
        y >= 0;
        z >= 0;
    cvx_end
    
    wealth = cvx_optval;
end
