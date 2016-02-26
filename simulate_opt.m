function [regret, wealth] = simulate_opt(policy, horizon, B, gamma)
% Inputs: 
%   policy : function handle to optimization function
%   horizon : Planning horizon for optimization
%   B : Uncertainty matrix
%   gamma : Box bound on uncertainty u
% Outputs: 
%   regret : Percentage distance from true optimality
%   wealth : Actual terminal wealth

    [c, A, b_real, b_hat, err_signal] = initialization(horizon, horizon);

    [x_opt, opt_val] = naive_opt(A, b_real);
    
    if isequal(policy, @simple_robust_opt)
        [x, rob_val] = policy(A, b_hat, B, gamma);
    end
    
    if isequal(policy, @recourse_opt)
        [x, X, rob_val] = policy(A, b_hat, b_real, B, gamma);
    end
    
    regret = 100*(opt_val - rob_val)/opt_val;
end

