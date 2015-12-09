function [b_hat, b_real] = generate_demand(n)
% Inputs: 
%   n : Number of data points to simulate
% Outputs: 
%   b_hat : Time series of estimated required net flow for all n
%   b_real : True time series of net flow requirements for all n
    b_profile = [150; 100; -200; 200; -50; -300];
    b_hat = b_profile + normrnd(0,10,length(b_profile),1);
    for i = 2:floor(n/6)+1
        b_hat = [b_hat; b_profile + normrnd(0,10,length(b_profile),1)];
    end
    b_hat = b_hat(1:n);

    u = (-1 + 2*rand(1,n));
    
    phi = [0.6 0.3 0.1];
    theta = [0.4 0.2]; 
    
    b_real = b_hat(1:3) + u(1:3)'; 
    for t = 4:n
        phi_n = phi + normrnd(0, 0, 1, 3);
        theta_n = theta + normrnd(0, 0, 1, 2);

        ar_sum = 0;
        for i = 1:3
            ar_sum = ar_sum + phi_n(i)*(b_real(t-i)-b_hat(t-i));
        end

        ma_sum = 0;
        for i = 1:2
            ma_sum = ma_sum + theta_n(i)*u(t-i); 
        end

        b_real(end+1) = b_hat(t) + ar_sum + ma_sum + u(t);
    end
end

