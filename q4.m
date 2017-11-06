clear all
close all

%% Question 3 : Measurement Model
x = [0 0 0];
measurement_model = [x(1) x(2) x(3)-99.7/180*pi];
measurement_model_disturbance = [randn(1)*0.5 randn(1)*0.5 randn(1)*10/180*pi];

%% Question 4: Extended Kalman Filter
dt = 0.1;
Tf = 20;
T = 0:dt:Tf;

R = [0.01 0.01 0.1*pi/180] .^2;
Q = [0.5 0.5 10/180*pi] .^2;

x = [0 0 0];
w = [0 -2 2];

mup = [0 0 0];
mu = [0 0 0];

S = 1*eye(3);

for t = 1 : length(T)
    % Calculate error and disturbance
    e = sqrt(R) * [randn(1) 0 0; 0 randn(1) 0; 0 0 randn(1)];
    d = sqrt(Q) * [randn(1) 0 0; 0 randn(1) 0; 0 0 randn(1)];
    
    % Calculate motion model and measurement model measurement
    x = motion_model(x, w) + e;
    y = [x(1) x(2) x(3)-99.7/180*pi];
    
    % Kalman Filter Prediction
    mup = motion_model(mu);
    Sp = S + R;
    
    
end
    

        
