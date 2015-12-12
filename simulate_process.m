%% Data generation
h = 6;
%[b_hat, b_real] = generate_demand(1000);
%err = b_real - b_hat;
load working2;
%% Naive uncertainty
rho = 1;
B_naive = uncertainty_naive(b_real, h, rho);

%% AR model
[Phi, u, gamma_ar] = recover_ar(err, 3);
B_ar = uncertainty_ar(Phi, h);

%% ARMA model
[Phi, Theta, u, gamma_arma] = recover_arma(err, 3, 2);
B_arma = uncertainty_arma(Phi, Theta, h);

%% Average regret naive
[regret_simple_naive, regret_recourse_naive] = average_regret(100, h, B_naive, 1);

%% Average regret AR
[regret_simple_ar, regret_recourse_ar] = average_regret(100, h, B_ar, gamma_ar);

%% Average regret ARMA
[regret_simple_arma, regret_recourse_arma] = average_regret(100, h, B_arma, gamma);



