clear all
clc

%% Initialization

% b_profile is defined the first time this way: 
% b=zeros(60,1);
% b(1:6)=b_profile;
% b(7:60)=-300+600*randi([0,10],54,1)/10;
% -> b_profile=[150;100;-200;200;-50;-300;0;60;-180;0;300;60;0;-180;0;60;120;-60;-60;300;-300;240;300;180;-240;-180;-120;120;-240;120;-240;120;0;180;120;240;240;-120;120;-180;-300;180;0;0;240;60;60;240;180;60;-180;-180;240;-300;0;-240;300;120;0;0];

[A,b_real,b_hat,err_signal,B] = initialization(6,6);
% save('initialization');

%% Naive Opt
[x,y,z] = naive_opt(A, b_hat);
%% Robust Opt
[x,y,z] = simple_robust_opt(A, b_hat, B);
%% Affine Recourse
[x,y,z,X,Y,Z] = recourse_opt(A, b_hat, B);

%% Uncertainty Naive
data = [];
for idx = 1:100
    [~,data(:,idx),~,~,~] = initialization(6,6);
end
data = data(:);
B_uncertainty_naive = uncertainty_naive(data, 6, 1);
%% Simulate Opt
[regret, wealth] = simulate_opt(@simple_robust_opt, 6);

%% Worst Case Regret
[simple_worst, recourse_worst] = worstcase_regret(5, 6);
%% Average Case Regret
[simple_avg, recourse_avg] = average_regret(5, 6);

    
    
    
    