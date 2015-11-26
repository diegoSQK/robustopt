function [regret, wealth] = simulate_opt(policy, horizon, order)
% Inputs: 
%   policy : function handle to optimization function
%   horizon : Planning horizon for optimization
%   order : Order of autoregressive model for uncertainty set recovery
% Outputs: 
%   wealth : Actual terminal wealth
%   regret : Percentage distance from true optimality

    [past_pred, past_real] = generate_demand(100);
    past_err = past_pred - past_real;
    B = uncertainty(past_err, order, horizon);
    [A, b_real, b_hat, err_signal] = initialization(horizon, horizon);

    [x_opt, y_opt, z_opt] = naive_opt(A, b_real);
    opt_wealth = z_opt(end);
    [x, y, z] = policy(A, b_hat, B);

    wealth = z(end);
    regret = 100*(opt_wealth - wealth)/opt_wealth;
end

