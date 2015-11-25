n = 100;
h = 6;
total = [0, 0];
for i = 1:n
    [r, w] = simulate_opt('simple', h, 2);
    total = total + [r, w];
end
simple_avg = total/n

total = [0, 0];
for i = 1:n
    [r, w] = simulate_opt('recourse', h, 2);
    total = total + [r, w];
end
recourse_avg = total/n

