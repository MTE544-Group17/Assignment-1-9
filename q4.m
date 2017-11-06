clear all
close all

%% Question 2 : Motion Model (Matrix form)
    r = 0.25; % wheel radius [m]
    l = 0.3; % robot frame radius [m]
    sample_time = 0.1; % time between samples [s]
    
    syms x1 x2 x3 u1 u2 u3;
    
    J = [-1/3  cosd(60)/3 cosd(60)/3;
            0 sind(-60)/2 sind(60)/2;
      1/(3*l)     1/(3*l)     1/(3*l)] .* (sample_time * r);
  
    K = [cos(x3) cos(x3 + pi/2) 0;
         sin(x3) sin(x3 + pi/2) 0;
            0        0         1];
        
    g = [x1; x2; x3] + K*J*[u1; u2; u3];
    
%     g = [x1 + (-u1/3 + u2 * cosd(60)/3 + u3 * cosd(60)/3) * cos(x3) - (u2 * sind(-60)/2 + u3 * sind(60)/2) * sin(x3);
%          x2 + (-u1/3 + u2 * cosd(60)/3 + u3 * cosd(60)/3) * sin(x3) + (u2 * sind(-60)/2 + u3 * sind(60)/2) * cos(x3);
%          x3 + u1 / (3*l) + u2 / (3*l) + u3 / (3*l)];
     
    G = jacobian(g,  [x1; x2; x3]);
    
% %% Question 3 : Measurement Model
% x = [0 0 0];
% measurement_model = [x(1); x(2); x(3)-99.7/180*pi];
% measurement_model_disturbance = [randn(1)*0.5; randn(1)*0.5; randn(1)*10/180*pi];
% 
% %% Question 4: Extended Kalman Filter
% dt = 0.1;
% Tf = 20;
% T = 0:dt:Tf;
% 
% R = [0.01 0.01 0.1*pi/180] .^2;
% Q = [0.5 0.5 10/180*pi] .^2;
% 
% x = [0; 0; 0];
% w = [0; -2; 2];
% 
% mup = [1; 1; 1];
% mu = [0; 0; 0];
% 
% S = 1*eye(3);
% 
% for t = 1 : length(T)
%     % Calculate error and disturbance
%     e = [randn(1) 0 0; 0 randn(1) 0; 0 0 randn(1)] * sqrt(R);
%     d = [randn(1) 0 0; 0 randn(1) 0; 0 0 randn(1)] * sqrt(R);
%     
%     % Calculate motion model and measurement model measurement
%     x = motion_model(x, w) + e;
%     y = [x(1) x(2) x(3)-99.7/180*pi];
%     
%     % Kalman Filter Prediction
%     mup = motion_model(mu);
%     Sp = S + R;
%     
%     
% end
%     
% 
%         
