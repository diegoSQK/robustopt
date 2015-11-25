function [A,b_real,b_hat,err_signal] = initialization(months, horizon)
% Inputs: 
%   months : Total length of simulated data
%   horizon : Planning horizon for optimization (defaults to 6)
% Outputs: 
%   A : Matrix encoding the cash-flow balance equations for a single planning horizon
%   b_real : True time series of net flow requirements for all months
%   b_hat : Time series of estimated required net flow for all months
%   err_signal : Difference between b_real and b_hat

    if nargin < 2
        horizon = 6;
    end
        
    A_X=eye(horizon);
    A_Y=eye(horizon-3);
    A_Z=-eye(horizon);

    for i=1:1:horizon-1
        A_X(i+1,i)=-1.01;
    end
    A_X = A_X(:,1:end-1);

    for i=1:1:horizon-3
        A_Y(i+3,i)=-1.02;
    end

    for i=1:1:horizon-1
        A_Z(i+1,i)=1.003;
    end

    [b_hat, b_real] = generate_demand(months);
    A=[A_X,A_Y,A_Z];

    err_signal=b_hat-b_real;

    %save('initialization');
end

