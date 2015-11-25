function regret = simulate_opt(policy, horizon, order)
% Inputs: 
%   policy : 'simple' or 'recourse'
%   horizon : Planning horizon for optimization
%   order : Order of autoregressive model for uncertainty set recovery
% Outputs: 
%   regret : Percentage distance from true optimality

    [past_pred, past_real] = generate_demand(100);
    past_err = past_pred - past_real;
    B = uncertainty(past_err, order, horizon);
    [A, b_real, b_hat, err_signal] = initialization(horizon, horizon);

    [x_opt, y_opt, z_opt] = naive_opt(A, b_real);
    opt_wealth = z_opt(end);

    if strcmp(policy, 'simple')
        [x, y, z] = simple_robust_opt(A, b_hat, B);
    end

    if strcmp(policy, 'recourse')
        [x, y, z] = recourse_opt(A, b_hat, B);
    end

    robust_wealth = z(end);
    regret = 100*(opt_wealth - robust_wealth)/opt_wealth;
end

