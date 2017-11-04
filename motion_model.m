function x_new = motion_model(x, w)
    %% Vehicle constants
    r = 0.25; % wheel radius [m]
    l = 0.3; % robot frame radius [m]
    sample_time = 0.1; % time between samples [s]
    
    %% Math
    v_x = (w(1) * sin(pi + x(3))+ w(2) * sin(-pi/3 + x(3)) + w(3) * sin(pi/3 + x(3))) * r;
    v_y = (w(1) * cos(pi + x(3))+ w(2) * cos(-pi/3 + x(3)) + w(3) * cos(pi/3 + x(3))) * r;
    v_theta = sum(w) * r/l;
    
    % Add noise
    v_x = v_x + randn(1) * 0.01;
    v_y = v_y + randn(1) * 0.01;
    v_theta = v_theta + randn(1) * 0.1;
    
    % Position Change
    d_x = v_x * sample_time;
    d_y = v_y * sample_time;
    d_theta = v_theta * sample_time;
    
    x_new = [x(1) + d_x, x(2) + d_y, x(3) + d_theta];
end

