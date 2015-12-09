function [simple_avg, recourse_avg] = average_regret(n, h)
% Inputs:
%   n : number of simulations to average
%   h : planning horizon length for each simulation
% Outputs
%   simple_avg : Three-element vector with first element the
%                average percent regret, second element the average
%                number of constraints not satisfied, and third 
%                element the average terminal wealth for the simple
%                robust policy
%
%   recourse_avg : Same as above, but using affine recourse
%                  policy

    total = [0, 0, 0, 0];
    k = 0;
    for i = 1:n
        [r, m, d, w] = simulate_opt(@simple_robust_opt, h);
        if ~isnan(r) && ~isnan(w) && ~isnan(m) && ~isnan(d)
            total = total + [r, m, d, w];
            k = k + 1;
        end
    end
    simple_avg = total/k

    total = [0, 0, 0, 0];
    k = 0;
    for i = 1:n
        [r, m, d, w] = simulate_opt(@recourse_opt, h);
        if ~isnan(r) && ~isnan(w) && ~isnan(m) && ~isnan(d)
            total = total + [r, m, d, w];
            k = k + 1;
        end
    end
    recourse_avg = total/k
end

