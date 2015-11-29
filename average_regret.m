function [simple_avg, recourse_avg] = average_regret(n, h)
% Inputs:
%   n : number of simulations to average
%   h : planning horizon length for each simulation
% Outputs
%   simple_avg : Two-element vector with first element the
%                average percent regret and second element
%                the average terminal wealth for the simple
%                robust policy
%
%   recourse_avg : Same as above, but using affine recourse
%                  policy

    total = [0, 0];
    for i = 1:n
        [r, w] = simulate_opt(@simple_robust_opt, h, 100, 2); %100 simulated scenarios
        total = total + [r, w];
    end
    simple_avg = total/n

    total = [0, 0];
    for i = 1:n
        [r, w] = simulate_opt(@recourse_opt, h, 100, 2); %100 simulated scenarios
        total = total + [r, w];
    end
    recourse_avg = total/n
end

