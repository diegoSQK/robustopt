function [simple_worst, recourse_worst] = worstcase_regret(n, h)
% Inputs:
%   n : number of simulations to average
%   h : planning horizon length for each simulation
% Outputs
%   simple_avg : Two-element vector with first element the
%                worst case percent regret and second element
%                the worst case terminal wealth for the simple
%                robust policy
%
%   recourse_avg : Same as above, but using affine recourse
%                  policy
    regret = [];
    wealth = [];
    for i = 1:n
        [r, w] = simulate_opt('simple', h, 2);
        regret = [regret, r];
        wealth = [wealth, w];
    end
    simple_worst = [max(regret), min(wealth)];

    regret = [];
    wealth = [];
    for i = 1:n
        [r, w] = simulate_opt('recourse', h, 2);
        regret = [regret, r];
        wealth = [wealth, w];
    end
    recourse_worst = [max(regret), min(wealth)];

end

