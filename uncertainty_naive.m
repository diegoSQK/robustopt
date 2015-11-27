function B = uncertainty_naive(data, horizon)
% Inputs:
%   data : time series of real demand
%   horizon : planning horizon length
% Outputs:
%   B : Diagonal matrix encoding naive uncertainty set

    data_matrix = [];
    for i = 1:horizon:length(data)-horizon+1
        data_vector = (data(i:i+horizon-1));
        data_matrix = [data_matrix, data_vector];
    end
    sigma = std(data_matrix, 1, 2);
    B = diag(3*sigma);
end

