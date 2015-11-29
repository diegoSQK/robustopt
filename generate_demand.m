function [b_hat, b_real, B] = generate_demand(n)
% Inputs: 
%   n : Number of data points to simulate
% Outputs: 
%   b_hat : Time series of estimated required net flow for all n
%   b_real : True time series of net flow requirements for all n
    
    % Method used to generate b_hat. It should be fixed from there. 
%     b_hat = [150; 100; -200; 200; -50; -300];
%     b_hat(1:6)=b_hat;
%     b_hat(7:60)=ceil(200*normrnd(0,1,54,1)/10)*10;
    b_hat = [150;100;-200;200;-50;-300;-420;-130;70;40;20;300;300;290;40;-10;-300;370;-400;40;170;-310;110;300;-110;-120;420;-230;-250;30;-180;20;80;80;-80;190;160;-140;370;-240;-80;260;-300;-60;-40;-150;-120;50;-160;-110;240;-250;170;-110;30;150;-170;-70;-130;-110];


    b_hat = b_hat(1:n);
    u = -1 + 2*rand(1,n);
    
    b_real=zeros(n,1);
    b_real(1) = b_hat(1)*(1+0.06*u(1));
    
    B = 0.06*eye(n); % The matrix approach is simpler, since we need B for the affine method afterwards
    for i=2:n
        b_real(i) = b_hat(i)*(1 + 0.06*u(i) + 0.02*u(i-1));
        B(i,i-1) = 0.02;
    end
    B = B*diag(b_hat);
    
end

