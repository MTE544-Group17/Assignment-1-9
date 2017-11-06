function x_est = measurement_model(x)
    x_est = x * [1; 1; -1;] + [randn(1)*0.5 randn(1)*0.5 randn(1)*10/180*pi + 99.7/180*pi];
end

