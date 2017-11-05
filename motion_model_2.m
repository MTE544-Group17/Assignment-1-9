function x_new = motion_model_2(x, w)
    %% Vehicle constants
    r = 0.25; % wheel radius [m]
    l = 0.3; % robot frame radius [m]
    sample_time = 0.1; % time between samples [s]
    
    %% Math
    vx = (-w(1) + w(2) * cosd(60) + w(3) * cosd(60)) / 3; 
    vy = (w(2) * sind(-60) + w(3) * sind(60)) / 2; 
    v_theta = mean(w);
    
    dx = vx * sample_time * r;
    dy = vy * sample_time * r;
    d_theta = v_theta * sample_time  * r/l;
    
    % add noise
    dx = dx + randn(1) * 0.01;
    dy = dy + randn(1) * 0.01;
    d_theta = d_theta + randn(1) * 0.1 * pi/180;
    
    x_new = [0 0 0];
    
    x_new(1) = x(1) + dx * cos(x(3)) + dy * cos(x(3) + pi/2);
    x_new(2) = x(2) + dx * sin(x(3)) + dy * sin(x(3) + pi/2);
    x_new(3) = x(3) + d_theta;
    
    if(x_new(3) > 2*pi)
        x_new(3) = x_new(3) - 2 * pi;
    end
end

