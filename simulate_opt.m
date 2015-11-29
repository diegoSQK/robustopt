function [regret, wealth] = simulate_opt(policy, horizon, n, order)
% Inputs: 
%   policy : function handle to optimization function
%   horizon : Planning horizon for optimization
%   order : Order of autoregressive model for uncertainty set recovery.
%           (Optional argument, naive method will be used if not specified)
% n: number of simulation
% Outputs: 
%   wealth : Actual terminal wealth
%   regret : Percentage distance from true optimality

%     [past_pred, past_real] = generate_demand(n);
%     past_err = past_real - past_pred;
    
    past_real = [];
    past_pred = [];
    for idx = 1:n
        [~,past_real(:,idx),past_pred(:,idx),~,~] = initialization(6,6);
    end
    past_real = past_real(:);
    past_pred = past_pred(:);
    past_err = past_real - past_pred;
    
    if nargin > 2
        B = uncertainty_auto(past_err, order, horizon);
    else
        B = uncertainty_naive(past_real, horizon, 1); % 1 standard deviation
    end

    [A, b_real, b_hat, ~,B_original] = initialization(horizon, horizon);

    [x_opt, y_opt, z_opt] = naive_opt(A, b_real);
    opt_wealth = z_opt(end);
    [x, y, z] = policy(A, b_hat, B);
    wealth = z(end);
    
    regret = 100*(z(end)-opt_wealth)/opt_wealth;
end

