clear all
close all

L = 0.3;
dt = 0.1;

x = [0; 0; 0];
x_history = ones(3, 250);
v = 3;

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
    delta = deg2rad(10 - t);
%     delta = -0.1;
    x = bicycle(x, v, delta, L, dt);
    
    x_history(:, i) = x;
    i = i+1;
    
    figure(1);clf; hold on;
    plot(x_history(1, 1:i-1), x_history(2, 1:i-1), 'ro--');
    axis([-10 10 -30 10]);
    if (makemovie) writeVideo(vidObj, getframe(gca)); end
end

if (makemovie) close(vidObj); end


