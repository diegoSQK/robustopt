function B = uncertainty(err_signal,p,n)
% Inputs: 
%   err_signal : Entire known error signal so far
%   p : Desired order of the autoregressive model
%   n : Planning horizon length
% Outputs:
%   B : Matrix encoding the recovered uncertainty set (b_real = b_hat + Bu)

    a = autocorr(err_signal);
    theta = levinson(a,p);
    Phi = zeros(n);
    for i = 1:n
        k = 1;
        for j = i:-1:1
            if k <= p+1
                Phi(i,j) = theta(k);
                k = k+1;
            end
        end
    end
    B = inv(Phi);
end

