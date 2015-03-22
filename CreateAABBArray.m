function [AABB_array] = CreateAABBArray(particleArray)
%min_pos and max_pos are the coordinates of the bottem left and upper right
%corners of the rectangle containing the circle

%number of objects
num = length(particleArray);
%initialize 2D array. format as described in class
AABB_array = zeros(4*num,3);
index = 0;

for ii = 1:num
    %Upper Left
    radius = particleArray(ii).r;
    index = index + 1;
    AABB_array(index,1) = particleArray(ii).x - radius;
    AABB_array(index,2) = particleArray(ii).y + radius;
    AABB_array(index,3) = ii;
    
    %Bottom Left
    index = index + 1;
    AABB_array(index,1) = particleArray(ii).x - radius;
    AABB_array(index,2) = particleArray(ii).y - radius;
    AABB_array(index,3) = ii;
    
    %Upper Right
    index = index + 1;
    AABB_array(index,1) = particleArray(ii).x + radius;
    AABB_array(index,2) = particleArray(ii).y + radius;
    AABB_array(index,3) = ii;
    
    %Bottom Right
    index = index + 1;
    AABB_array(index,1) = particleArray(ii).x + radius;
    AABB_array(index,2) = particleArray(ii).y - radius;
    AABB_array(index,3) = ii;
end