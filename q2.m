close all;
clear all;

%% Given inputs
w = [-1.5; 2; 1]; 

x = [0; 0; 0];
x_history = zeros(3, 150);

for i = 1:150
    motion_model_disturbance = [randn(1)*0.01; randn(1)*0.01; randn(1)*0.1*pi/180];
    x = motion_model(x, w) + motion_model_disturbance;
    x_history(:,i) = x;
end

figure;
plot(x_history(1, :) , x_history(2, :));
% hold on
% quiver(x_history(1,:) , x_history(2,:), cos(x_history(3,:)), sin(x_history(3,:)));
title('Test run');
axis([-2 2 -2 2]);

%% Straight line
w = [0; -2; 2]; 

x = [0; 0; 0];
x_history = zeros(3, 150);

for i = 1:150
    motion_model_disturbance = [randn(1)*0.01; randn(1)*0.01; randn(1)*0.1*pi/180];
    x = motion_model(x, w) + motion_model_disturbance;
    x_history(:,i) = x;
end
figure;
plot(x_history(1, :) , x_history(2, :));
% hold on
% quiver(x_history(1,:) , x_history(2,:), cos(x_history(3,:)), sin(x_history(3,:)));
title('Straight line');
axis([-2 2 -1 8]);

%% 2m diameter circle
w = [0; 0; 0];

w(1) = 2*pi/15*30/25*3;
w(2) = -pi/15/sind(6);
w(3) = -w(2);

x = [0; 0; 0];
x_history = zeros(3, 150);

for i = 1:150
    motion_model_disturbance = [randn(1)*0.01; randn(1)*0.01; randn(1)*0.1*pi/180];
    x = motion_model(x, w) + motion_model_disturbance;
    x_history(:,i) = x;
end
figure;
plot(x_history(1, :) , x_history(2, :));
% hold on
% quiver(x_history(1,:) , x_history(2,:), cos(x_history(3,:)), sin(x_history(3,:)));
title('2m Diameter circle');
axis([-3 1 -2 2]);

%% Spiral
w = [3; -2; 2];

x = [0; 0; 0];
x_history = zeros(3, 1500);

for i = 1:1500
    w(2) = w(2) - 0.02;
    w(3) = -w(2);
    motion_model_disturbance = [randn(1)*0.01; randn(1)*0.01; randn(1)*0.1*pi/180];
    x = motion_model(x, w) + motion_model_disturbance;
    x_history(:,i) = x;
end    
figure;
plot(x_history(1, :) , x_history(2, :));
% hold on
% quiver(x_history(1,:) , x_history(2,:), cos(x_history(3,:)), sin(x_history(3,:)));
title('Spiral');
axis([-5 5 -5 5]);


