clear all
close all

% Robot start position
dxy = 0.1;

% Target location
searchgoal = [50 10];
startpos = [40; 5; pi];

L = 0.3;
dt = 0.1;
r = 3;
gain = 0.5;

x = [40; 5; pi];
x_history = ones(3, 250);
v = 3;

I = imread('IGVCmap.jpg');
map = im2bw(I, 0.7); % Convert to 0-1 image
map = 1-map; % Convert to 0 free, 1 occupied and flip.
[M,N]= size(map); % Map size

map_OC = robotics.BinaryOccupancyGrid(map, 1/dxy);
prm = robotics.PRM(map_OC, 400);
prm.ConnectionDistance = 20;

path = findpath(prm, [x(1) x(2)], searchgoal);
show(prm, 'Path', 'on');

path = interpolate(path)';

% Create AVI object
makemovie = 1;
if(makemovie)
    vidObj = VideoWriter('q1.avi');
    vidObj.Quality = 100;
    vidObj.FrameRate = 8;
    open(vidObj);
end

i = 1;

for t=0:dt:2000000
    target_index = closest_point(x(1), x(2), path) + r;
    
    if target_index > length(path)
        r = r - 1;
        target_index = closest_point(x(1), x(2), path) + r;
    end
    
    if r == 0
        break;
    end
    
    direction_vec = [path(1, target_index) - x(1); path(2, target_index) - x(2)];
    
    theta = - atan2(direction_vec(2), direction_vec(1));
    
    heading_err = theta - x(3);
    
    delta = heading_err * gain;
    
    x = bicycle(x, v, delta, L, dt);
    
    x_history(:, i) = x;
    i = i+1;
    
    % Plotting
    figure(2);clf; hold on;
    colormap('gray');
    imagesc(1-flipud(map));
    axis([0 926 0 716]);
    plot(path(1, :)*10, path(2, :)*10, 'bx-', 'MarkerSize',0.5, 'LineWidth', 0.2);
    plot(x_history(1, 1:i-1)*10, x_history(2, 1:i-1)*10, 'ro--', 'MarkerSize',2, 'LineWidth', 1);
    
    plot(startpos(1)*10, startpos(2)*10, 'ro', 'MarkerSize',10, 'LineWidth', 0.3);
    plot(searchgoal(1)*10, searchgoal(2)*10, 'gx', 'MarkerSize',10, 'LineWidth', 0.3 );
    plot(path(1, :)*10, path(2, :)*10, 'bx', 'MarkerSize',5); 

    if (makemovie) writeVideo(vidObj, getframe(gca)); end
end

if (makemovie) close(vidObj); end