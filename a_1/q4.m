clear all
close all

%% Question 2 : Motion Model (Matrix form)
    r = 0.25; % wheel radius [m]
    l = 0.3; % robot frame radius [m]
    sample_time = 0.1; % time between samples [s]
    
    syms x1 x2 x3 u1 u2 u3;
    
    j = [-1/3  cosd(60)/3 cosd(60)/3;
            0 sind(-60)/2 sind(60)/2;
      1/(3*l)     1/(3*l)     1/(3*l)] .* (sample_time * r);
  
    k = [cos(x3) -sin(x3) 0;
         sin(x3) cos(x3) 0;
            0        0         1];
        
    g = [x1; x2; x3] + k*j*[u1; u2; u3];
    
%     g = [x1 + (-u1/3 + u2 * cosd(60)/3 + u3 * cosd(60)/3) * cos(x3) - (u2 * sind(-60)/2 + u3 * sind(60)/2) * sin(x3);
%          x2 + (-u1/3 + u2 * cosd(60)/3 + u3 * cosd(60)/3) * sin(x3) + (u2 * sind(-60)/2 + u3 * sind(60)/2) * cos(x3);
%          x3 + u1 / (3*l) + u2 / (3*l) + u3 / (3*l)];
     
    G = jacobian(g,  [x1; x2; x3]);
    
%% Question 3 : Measurement Model
% x = [0 0 0];
% measurement_model = [x(1); x(2); x(3)-99.7/180*pi];
% measurement_model_disturbance = [randn(1)*0.5; randn(1)*0.5; randn(1)*10/180*pi];
H = [1 0 0;
    0 1 0;
    0 0 1];

%% Question 4: Extended Kalman Filter

% Create AVI object
makemovie = 1;
if(makemovie)
    vidObj = VideoWriter('ekf.avi');
    vidObj.Quality = 100;
    vidObj.FrameRate = 8;
    open(vidObj);
end

dt = 0.1;
Tf = 15;
T = 0:dt:Tf;

R = [0.01 0 0; 0 0.01 0; 0 0 0.1*pi/180] .^2;
Q = [0.5 0 0; 0 0.5 0; 0 0 10/180*pi] .^2;

x = [1; 1; pi/2];
u = [-1.5; 2; 1];

mup = [5; 5; 1];
mu = [5; 5; 1];

S = 1*eye(3);

x_history = zeros(3, length(T));
mup_S = zeros(3, length(T));
mu_S = zeros(3, length(T));

for t = 1 : length(T)
    % Calculate error and disturbance
%     e = [randn(1);randn(1);randn(1)] * (sqrt(R) * [1; 1; 1]);
    e = normrnd(0,sqrt([R(1,1);R(2,2);R(3,3)]));
%     d = [randn(1);randn(1);randn(1)] * (sqrt(Q) * [1; 1; 1]);
    d = normrnd(0,sqrt([Q(1,1);Q(2,2);Q(3,3)]));
    
    % Calculate motion model and measurement model measurement
    x = motion_model(x, u) + e;
    y = [x(1); x(2); x(3)-9.7/180*pi] + d;
    
    
    %%% Kalman Filter Prediction
    
    % Propagate mu through the nonlinear motion model
    mup = motion_model(mu,u);
    
    % Linearized motion model at the predicted mean
    x1 = mup(1);
    x2 = mup(2);
    x3 = mup(3);
    u1 = u(1);
    u2 = u(2);
    u3 = u(3);
    G_t = double(vpa(subs(G)));
    
    % Compute predicted covariance
    Sp = G_t*S*G_t' + R;
    
    %%% Measurement update
    % Linearized measurement model at the predicted mean     
    H_t = eye(3);
    
    % Compute Kalman gain
    Kg = Sp*H_t'*inv(H_t*Sp*H_t' + Q);
    
    % Update mean using the nonlinear measurement model
    mu = mup + Kg*(y-[mup(1); mup(2); mup(3)-9.7/180*pi]);
    
    % Update the covariance based on the measurement model
    S = (eye(length(mu))-Kg*H_t)*Sp;
    
    x_history(:,t) = x;
    
    % Store results
    mup_S(:,t) = mup;
    mu_S(:,t) = mu;
%     K_S(:,t) = Kg;

    % Plot results
    figure(1);clf; hold on;
    plot(0,0,'bx', 'MarkerSize', 6, 'LineWidth', 2)
    plot([20 -1], [0 0],'b--')
    plot(x_history(1, 2:t), x_history(2, 2:t), 'ro--')
    mu_pos = [mu(1) mu(2)];
    plot(mu_S(1,2:t), mu_S(2,2:t), 'bx--')
    S_pos = [S(1,1) S(1,2); S(2,1) S(2,2)];
    error_ellipse(S_pos, mu_pos, 0.75);
    error_ellipse(S_pos, mu_pos, 0.95);
    title('True state and belief')
    axis equal
    axis([-1 4 -3 3])
    if (makemovie) writeVideo(vidObj, getframe(gca)); end

end
if (makemovie) close(vidObj); end