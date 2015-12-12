function [simple_avg, recourse_avg] = average_regret(n, h, B, gamma)
% Inputs:
%   n : number of simulations to average
%   h : planning horizon length for each simulation
% Outputs
%   simple_avg : Three-element vector with first element the
%                average percent regret, second element the average
%                depletion of reserves as percent of wealth, and third 
%                element the average terminal wealth for the simple
%                robust policy
%
%   recourse_avg : Same as above, but using affine recourse
%                  policy

    total = [0, 0];
    k = 0;
    for i = 1:n
        [r, w] = simulate_opt(@simple_robust_opt, h, B, gamma);
        if ~isnan(r) && ~isnan(w)
            total = total + [r, w];
            k = k + 1;
        end
    end
    simple_avg = total/k

    total = [0, 0];
    k = 0;
    for i = 1:n
        [r, w] = simulate_opt(@recourse_opt, h, B, gamma);
        if ~isnan(r) && ~isnan(w) 
            total = total + [r, w];
            k = k + 1;
        end
    end
    recourse_avg = total/k
end

