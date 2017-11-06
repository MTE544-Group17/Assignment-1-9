close all;
clear all;

%% Given inputs
w = [-1.5 2 1]; 

x = [0 0 0];
x_history = zeros(150, 3);

for i = 1:150
    x = motion_model(x, w);
    x_history(i,:) = x;
end
figure;
plot(x_history(:, 1) , x_history(:, 2));
title('Test run');
axis([-5 5 -5 5]);

%% Straigt line
w = [0 -2 2]; 

x = [0 0 0];
x_history = zeros(150, 3);

for i = 1:150
    x = motion_model(x, w);
    x_history(i,:) = x;
end    
figure;
plot(x_history(:, 1) , x_history(:, 2));
title('Straight line');
axis([-5 5 -5 5]);

%% 2m diameter circle
w = [0 0 0];

w(1) = 2*pi/15*30/25*3;
w(2) = pi/15/sind(6);
w(3) = -w(2);

x = [0 0 0];
x_history = zeros(150, 3);

for i = 1:150
    x = motion_model(x, w);
    x_history(i,:) = x;
end    
figure;
plot(x_history(:, 1) , x_history(:, 2));
title('2m Diameter circle');
axis([-5 5 -5 5]);

%% Spiral
w = [3 2 -2];

x = [0 0 0];
x_history = zeros(1500, 3);

for i = 1:1500
    w(2) = w(2) + 0.02;
    w(3) = -w(2);
    x = motion_model(x, w);
    x_history(i,:) = x;
end    
figure;
plot(x_history(:, 1) , x_history(:, 2));
title('Spiral');
axis([-5 5 -5 5]);


