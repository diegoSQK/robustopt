function [x,y,z,X,Y,Z,wealth] = recourse_opt(A, b_hat, b_real, B, gamma)
% Inputs:
%   A : Constraint matrix
%   b_hat : Predicted flow requirements
%   B : Uncertainty matrix (b_real = b_hat + Bu)
% Outputs:
%   x,y,z,X,Y,Z : Decision variables and recourse matrices

    horizon = length(b_hat);
    c = zeros(1,horizon);
    c(end) = 1;

    cvx_begin quiet
        variable x(horizon-1,1);
        variable X(horizon-1,horizon) lower_triangular;
        variable y(horizon-3,1);
        variable Y(horizon-3, horizon) lower_triangular;
        variable z(horizon,1);
        variable Z(horizon, horizon) lower_triangular;
        maximize ( z(horizon) - gamma*c*sum(abs(Z),2) );
        A*[x; y; z] >= b_hat + gamma*sum(abs(A*[X;Y;Z]-B),2);
        x <= 100 - gamma*sum(abs(X),2);
        x >= gamma*sum(abs(X),2);
        y >= gamma*sum(abs(Y),2);
        z >= gamma*sum(abs(Z),2);
        diag(X) == 0;
        diag(Y) == 0;
        diag(Z) == 0;
    cvx_end
    
    u = inv(B)*(b_real - b_hat);
    v = [x;y;z];
    V = [X;Y;Z];
    reserve = (v + V*u);
    wealth = reserve(end);
end
