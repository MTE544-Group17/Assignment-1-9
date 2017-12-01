clear all
close all

L = 0.3;
dt = 0.1;
r = 3;
gain = 0.5;

x = [0; 0; 0];
x_history = ones(3, 250);
v = 3;

set_path = ones(2, 100);
set_path(:, 1:40) = [0:0.5:19.5; zeros(1, 40)];
set_path(:, 41:50) = [ones(1, 10) * 20; 0:0.5:4.5];
set_path(:, 51:90) = [20:-0.5:0.5; ones(1, 40) * 5];
set_path(:, 91:100) = [zeros(1, 10); 5:-0.5:0.5];

% Create AVI object
makemovie = 1;
if(makemovie)
    vidObj = VideoWriter('q1.avi');
    vidObj.Quality = 100;
    vidObj.FrameRate = 8;
    open(vidObj);
end

i = 1;

for t=0:dt:20
    target_index = closest_point(x(1), x(2), set_path) + r;
    
    if target_index > length(set_path)
        r = r - 1;
        target_index = closest_point(x(1), x(2), set_path) + r;
    end
    
    if r == 0
        break
    end
    
    direction_vec = [set_path(1, target_index) - x(1); set_path(2, target_index) - x(2)];
    
    theta = - atan2(direction_vec(2), direction_vec(1));
    
    heading_err = theta - x(3);
    
    delta = heading_err * gain;
    
    x = bicycle(x, v, delta, L, dt);
    
    x_history(:, i) = x;
    i = i+1;
    
    figure(1);clf; hold on;
    axis([-15 25 -10 10]);
    plot(x_history(1, 1:i-1), x_history(2, 1:i-1), 'ro--');
    plot(set_path(1, :), set_path(2, :), 'bx-');
    if (makemovie) writeVideo(vidObj, getframe(gca)); end
end

if (makemovie) close(vidObj); end


