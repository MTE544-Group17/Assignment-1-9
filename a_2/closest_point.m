function index = closest_point( x, y , path)
    min_dist = 999.0;
    index = 0;
    
    for i = 1:length(path)
       dist = sqrt((x - path(1, i)) ^ 2 + (y - path(2, i)) ^ 2);
       
       if dist < min_dist
           min_dist = dist;
           index = i;
       end
       
    end
    
end

