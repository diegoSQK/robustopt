%% Data generation
h = 6;
t = 300*h;
v = 60*h;
[b_hat_train, b_real_train] = generate_demand(t);
[b_hat_val, b_real_val] = generate_demand(v);
err_train = b_real_train - b_hat_train;
err_val = b_real_val - b_hat_val;

%% Naive uncertainty set error
rho = 2;
B_naive = uncertainty_naive(b_real_train, h, rho);
members = 0;
for i = 1:6:t-h+1
    members = members + membership_test(b_real_train(i:i+h-1), b_hat_train(i:i+h-1), B_naive, 1);
end
B_naive_train_error = 1 - (members/(t/h));

members = 0;
for i = 1:6:v-h+1
    members = members + membership_test(b_real_val(i:i+h-1), b_hat_val(i:i+h-1), B_naive, 1);
end
B_naive_val_error = 1 - (members/(v/h));
    

%% AR error
[Phi_ar, u_ar, gamma_ar] = recover_ar(err_train, 3);
train_error_ar = (norm(Phi_ar*err_train - err_train)^2)/t;
val_error_ar = (norm(Phi_ar(1:v,1:v)*err_val - err_val)^2)/v;

%% AR uncertainty set error
B_ar = uncertainty_ar(Phi_ar, h);
members = 0;
for i = 1:6:t-h+1
    members = members + membership_test(b_real_train(i:i+h-1), b_hat_train(i:i+h-1), B_ar, gamma_ar);
end
B_ar_train_error = 1 - (members/(t/h));

members = 0;
for i = 1:6:v-h+1
    members = members + membership_test(b_real_val(i:i+h-1), b_hat_val(i:i+h-1), B_ar, gamma_ar);
end
B_ar_val_error = 1 - (members/(v/6));

%% ARMA error
[Phi_arma, Theta_arma, u_arma, gamma_arma] = recover_arma(err_train, 3, 2);
train_error_arma = (norm(Phi_arma*err_train + Theta_arma*u_arma - err_train)^2)/t;

B_val = uncertainty_arma(Phi_arma, Theta_arma, v);
u_val = pinv(B_val)*(b_real_val - b_hat_val);

val_error_arma = (norm(Phi_arma(1:v,1:v)*err_val + Theta_arma(1:v,1:v)*u_val - err_val)^2)/v;

%% ARMA uncertainty set error
B_arma = uncertainty_arma(Phi_arma, Theta_arma, h);
members = 0;
for i = 1:6:t-h+1
    members = members + membership_test(b_real_train(i:i+h-1), b_hat_train(i:i+h-1), B_arma, gamma_arma);
end
B_arma_train_error = 1 - (members/(t/h));

members = 0;
for i = 1:6:v-h+1
    members = members + membership_test(b_real_val(i:i+h-1), b_hat_val(i:i+h-1), B_arma, gamma_arma);
end
B_arma_val_error = 1 - (members/(v/h));
