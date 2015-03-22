% %INPUT: POSITIONS and VELOCITIES (X & Y) of BOTH PARTICLES and if INELASTIC
function [v1x_after,v2x_after,v1y_after,v2y_after] = Reverse_Velocity(first,second,inelastic,e)

%Position and Velocity of Particle 1
px1 = first.x;
py1 = first.y;
v1x = first.vx;
v1y = first.vy;
m1 = first.m;

%Position and Velocity of Particle 2
px2 = second.x;
py2 = second.y;
v2x = second.vx;
v2y = second.vy;
m2 = second.m;

%Define rotation angle between x-y and t-n frame
theta = atand((px2 - px1)/(py1 - py2));

%BEFORE COLLISION
%Convert x-y velocities to t-n velocities
%Particle 1
v1t = v1x*cosd(theta) + v1y*sind(theta);
v1n = -v1x*sind(theta) + v1y*cosd(theta);

%Particle 2
v2t = v2x*cosd(theta) + v2y*sind(theta);
v2n = -v2x*sind(theta) + v2y*cosd(theta);

%AFTER COLLISION
%Velocity tangential to contact plane remain unchanged
v1t_after = v1t;
v2t_after = v2t;

%Velocity normal to contact plane depends on type of collision
if inelastic == 1 %Inelastic
    %Inelastic Collision Equations
    %Conservation of Momentum
    v2n_after = (v1n*(1+e)+v2n*((m2/m1) - e))/(1+m2/m1);
    v1n_after = v1n + (m2/m1)*v2n - (m2/m1)*v2n_after;
else 
    %Elastic Collision Equations
    %Simply swap components
    v1n_after = v2n;
    v2n_after = v1n;
end

%Convert t-n to x-y velocities
%Particle 1
v1x_after = v1t_after * cosd(theta) - v1n_after * sind(theta);
v1y_after = v1n_after * cosd(theta) + v1t_after * sind(theta);
%Partcle 2
v2x_after = v2t_after * cosd(theta) - v2n_after * sind(theta);
v2y_after = v2n_after * cosd(theta) + v2t_after * sind(theta);
end


