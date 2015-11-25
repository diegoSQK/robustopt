function [b_hat, b_real] = generate_demand(n)
% Inputs: 
%   n : Number of data points to simulate
% Outputs: 
%   b_hat : Time series of estimated required net flow for all n
%   b_real : True time series of net flow requirements for all n
    u = -1 + 2*rand(1,n);
    b_profile = [150; 100; -200; 200; -50; -300];

    b_hat = b_profile + normrnd(0,10,length(b_profile),1);
    for i = 2:floor(n/6)+1
        b_hat = [b_hat; b_profile + normrnd(0,10,length(b_profile),1)];
    end
    b_hat = b_hat(1:n);

    b_real=zeros(n,1);
    b_real(1) = b_hat(1)*(1+0.06*u(1));
    for i=2:n
        a0 = normrnd(0.06, 0.005);
        a1 = normrnd(0.02, 0.001);
        b_real(i) = b_hat(i)*(1 + a0*u(i) + a1*u(i-1));
    end
end

