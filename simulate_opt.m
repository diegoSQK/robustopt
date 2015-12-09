function [regret, misses, depletion, wealth] = simulate_opt(policy, horizon, order)
% Inputs: 
%   policy : function handle to optimization function
%   horizon : Planning horizon for optimization
%   order : Order of autoregressive model for uncertainty set recovery.
%           (Optional argument, naive method will be used if not specified)
% Outputs: 
%   regret : Percentage distance from true optimality
%   misses : Percentage of real data points which fell outside the
%            uncertainty set
%   depletion : Amount removed from reserves to meet unsatisfied
%              constraints (as percentage of wealth)
%   wealth : Actual terminal wealth

    [past_pred, past_real] = generate_demand(100);
    past_err = past_pred - past_real;
    
    if nargin > 2
        B = uncertainty_auto(past_err, order, horizon);
    else
        B = uncertainty_naive(past_real, horizon, 1);
    end

    [A, b_real, b_hat, err_signal] = initialization(horizon, horizon);

    [x_opt, y_opt, z_opt, opt_wealth] = naive_opt(A, b_real);
    
    if isequal(policy, @simple_robust_opt)
        [x, y, z, wealth] = policy(A, b_hat, B);
    end
    
    if isequal(policy, @recourse_opt)
        [x, y, z, X, Y, Z, wealth] = policy(A, b_hat, b_real, B);
    end
    
    misses = 100*sum(A*[x;y;z] < b_real)/horizon;
    diff = b_real - A*[x;y;z];
    depletion = 100*sum(diff(find(diff > 0)))/wealth;

    regret = 100*(opt_wealth - wealth)/opt_wealth;
end

