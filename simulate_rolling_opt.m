function [regret, wealth] = simulate_rolling_opt(policy, horizon, periods, order)
% Inputs: 
%   policy : function handle to optimization function
%   horizon : Planning horizon for optimization
%   periods : Number of planning periods to simulate
%   order : Order of autoregressive model for uncertainty set recovery
% Outputs: 
%   wealth : Actual terminal wealth
%   regret : Percentage distance from true optimality for each planning period

    [past_pred, past_real] = generate_demand(horizon);
    past_err = past_pred - past_real;
    months = periods*horizon;
    [A, b_real, b_hat, err_signal] = initialization(months, horizon);

    err_seen = past_err;
    regret = [];
    for m = 1:horizon:months
        b_r = b_real(m:m+horizon-1);
        b_h = b_hat(m:m+horizon-1);

        [x_opt, y_opt, z_opt] = naive_opt(A, b_r);
        opt_wealth = z_opt(end);

        B = uncertainty(err_seen, order, horizon);
        [x, y, z] = policy(A, b_h, B);
        wealth = z(end);

        r = 100*(opt_wealth - wealth)/opt_wealth;
        regret = [regret, r];
        err_seen = [err_seen; err_signal(m:m+horizon-1)];
    end
end

