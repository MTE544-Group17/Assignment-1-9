function x_new = motion_model(x, w)
    %% Vehicle constants
    r = 0.25; % wheel radius [m]
    l = 0.3; % robot frame radius [m]
    sample_time = 0.1; % time between samples [s]
    
    %% Set up and move reference points
    % X and Y coodrinates of points on the base in contact with the wheels.
    x_p = [0 l; cosd(210)*l sind(210)*l; cosd(330)*l sind(330)*l];
    % Tangential and normal velocities at each point in x_p 
    % Tangential is in the direction of the wheel velocity
    % Normal is positive away from the center of the base
    v_p = [0 0; 0 0; 0 0];
   
    % Point 1 (top)
    % Tangential velocity [m/s]
    v_p(1,1) = (w(1) - (w(2) + w(3)) * cosd(60)) / 3;
    v_p(1,1) = v_p(1,1) * r;
    % Normal velocity [m/s]
    v_p(1,2) = (w(2) * sind(-60) + w(3) * sind(60)) / 2;
    v_p(1,2) = v_p(1,2) * r;
    
    % Point 2 (left)
    % Tangential velocity [m/s]
    v_p(2,1) = (w(2) - (w(1) + w(3)) * cosd(60)) / 3;
    v_p(2,1) = v_p(2,1) * r;
    % Normal velocity [m/s]
    v_p(2,2) = (w(3) * sind(-60) + w(1) * sind(60)) / 2;
    v_p(2,2) = v_p(2,2) * r;
    
    % Point 3 (right)
    % Tangential velocity [m/s]
    v_p(3,1) = (w(3) - (w(2) + w(1)) * cosd(60)) / 3;
    v_p(3,1) = v_p(3,1) * r;
    % Normal velocity [m/s]
    v_p(3,2) = (w(1) * sind(-60) + w(2) * sind(60)) / 2;
    v_p(3,2) = v_p(3,2) * r;
        
    % New point pos [x, y] [m]
    x_p(1,1) = x_p(1,1) + v_p(1,1) * sample_time * cosd(90 + 90) + v_p(1,2) * sample_time * cosd(90);
    x_p(1,2) = x_p(1,2) + v_p(1,1) * sample_time * sind(90 + 90) + v_p(1,2) * sample_time * sind(90);
    
    x_p(2,1) = x_p(2,1) + v_p(2,1) * sample_time * cosd(210 + 90) + v_p(2,2) * sample_time * cosd(210);
    x_p(2,2) = x_p(2,2) + v_p(2,1) * sample_time * sind(210 + 90) + v_p(2,2) * sample_time * sind(210);
    
    x_p(3,1) = x_p(3,1) + v_p(3,1) * sample_time * cosd(330 + 90) + v_p(3,2) * sample_time * cosd(330);
    x_p(3,2) = x_p(3,2) + v_p(3,1) * sample_time * sind(330 + 90) + v_p(3,2) * sample_time * sind(330);    
    
    %% Calculating new global postition and heading
    % calculate local translation vector of the center of the base
    trans_local = [mean(x_p(:,1)) mean(x_p(:,2))];
    % calculate the local angular displacement vector
    ang_disp_local = atan2((x_p(1,2) - trans_local(2)) , (x_p(1,1) - trans_local(1))) - pi/2;
    
    % calculate the global changes
    x_new = [0 0 0];
    
    x_new(1) = x(1) + trans_local(1) * cos(x(3)) + trans_local(2) * cos(pi/2 + x(3)) + randn(1) * 0.01;
    x_new(2) = x(2) + trans_local(1) * sin(x(3)) + trans_local(2) * sin(pi/2 + x(3)) + randn(1) * 0.01;
    x_new(3) = x(3) + ang_disp_local + randn(1) * 0.1/180*pi;
end

