function path = interpolate( path_low_res )

    point_dist = 3;

    path = path_low_res(1, :);
    for i = 1:length(path_low_res)-1
        p1 = path_low_res(i, :);
        p2 = path_low_res(i+1, :);
        
        dist = floor(sqrt((p1(1) - p2(1)) ^ 2 + (p1(2) - p2(2)) ^2));
        
        if dist > point_dist
            for j = 0:point_dist:dist
                p = j * (p2 - p1) / dist;
                path = [path; p1 + p];
            end
        else
            path = [path; p1];
        end
    end
end

