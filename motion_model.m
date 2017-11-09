function x_new = motion_model(x, u)
    %% Vehicle constants
    r = 0.25; % wheel radius [m]
    l = 0.3; % robot frame radius [m]
    sample_time = 0.1; % time between samples [s]
    
    %% Math    
    J = [0  -(sqrt(3)/3) sqrt(3)/3;
         2/3 -1/2 -1/2;
         1/(3*l)   1/(3*l)   1/(3*l)] .* (sample_time * r);
    
    K = [cos(x(3)) -sin(x(3)) 0;
         sin(x(3)) cos(x(3)) 0;
                 0        0         1];
    
    x_new = x + K*J*u;

%     if(x_new(3) > 2*pi)
%         x_new(3) = x_new(3) - 2 * pi;
%     elseif(x_new(3) < 0)
%         x_new(3) = x_new(3) + 2 * pi;
%     end
end