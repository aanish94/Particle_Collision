function dtc = Collision_Times(collisions)
dtc = intmin;

for i = 1:length(collisions(:,1))
    %Position/Velocity of colliding particles
    x1 = collisions(i,1).x;
    y1 = collisions(i,1).y;
    r1 = collisions(i,1).r;
    vx1 = collisions(i,1).vx;
    vy1 = collisions(i,1).vy;
    
    x2 = collisions(i,2).x;
    y2 = collisions(i,2).y;
    r2 = collisions(i,2).r;
    vx2 = collisions(i,2).vx;
    vy2 = collisions(i,2).vy;
    
    t1 =   ((r1^2*vx1^2 - 2*r1^2*vx1*vx2 + r1^2*vx2^2 + r1^2*vy1^2 - 2*r1^2*vy1*vy2 + r1^2*vy2^2 + 2*r1*r2*vx1^2 - 4*r1*r2*vx1*vx2 + 2*r1*r2*vx2^2 + 2*r1*r2*vy1^2 - 4*r1*r2*vy1*vy2 + 2*r1*r2*vy2^2 + r2^2*vx1^2 - 2*r2^2*vx1*vx2 + r2^2*vx2^2 + r2^2*vy1^2 - 2*r2^2*vy1*vy2 + r2^2*vy2^2 - vx1^2*y1^2 + 2*vx1^2*y1*y2 - vx1^2*y2^2 + 2*vx1*vx2*y1^2 - 4*vx1*vx2*y1*y2 + 2*vx1*vx2*y2^2 + 2*vx1*vy1*x1*y1 - 2*vx1*vy1*x1*y2 - 2*vx1*vy1*x2*y1 + 2*vx1*vy1*x2*y2 - 2*vx1*vy2*x1*y1 + 2*vx1*vy2*x1*y2 + 2*vx1*vy2*x2*y1 - 2*vx1*vy2*x2*y2 - vx2^2*y1^2 + 2*vx2^2*y1*y2 - vx2^2*y2^2 - 2*vx2*vy1*x1*y1 + 2*vx2*vy1*x1*y2 + 2*vx2*vy1*x2*y1 - 2*vx2*vy1*x2*y2 + 2*vx2*vy2*x1*y1 - 2*vx2*vy2*x1*y2 - 2*vx2*vy2*x2*y1 + 2*vx2*vy2*x2*y2 - vy1^2*x1^2 + 2*vy1^2*x1*x2 - vy1^2*x2^2 + 2*vy1*vy2*x1^2 - 4*vy1*vy2*x1*x2 + 2*vy1*vy2*x2^2 - vy2^2*x1^2 + 2*vy2^2*x1*x2 - vy2^2*x2^2)^(1/2) + vx1*x1 - vx1*x2 - vx2*x1 + vx2*x2 + vy1*y1 - vy1*y2 - vy2*y1 + vy2*y2)/(vx1^2 - 2*vx1*vx2 + vx2^2 + vy1^2 - 2*vy1*vy2 + vy2^2);
    t2 =  -((r1^2*vx1^2 - 2*r1^2*vx1*vx2 + r1^2*vx2^2 + r1^2*vy1^2 - 2*r1^2*vy1*vy2 + r1^2*vy2^2 + 2*r1*r2*vx1^2 - 4*r1*r2*vx1*vx2 + 2*r1*r2*vx2^2 + 2*r1*r2*vy1^2 - 4*r1*r2*vy1*vy2 + 2*r1*r2*vy2^2 + r2^2*vx1^2 - 2*r2^2*vx1*vx2 + r2^2*vx2^2 + r2^2*vy1^2 - 2*r2^2*vy1*vy2 + r2^2*vy2^2 - vx1^2*y1^2 + 2*vx1^2*y1*y2 - vx1^2*y2^2 + 2*vx1*vx2*y1^2 - 4*vx1*vx2*y1*y2 + 2*vx1*vx2*y2^2 + 2*vx1*vy1*x1*y1 - 2*vx1*vy1*x1*y2 - 2*vx1*vy1*x2*y1 + 2*vx1*vy1*x2*y2 - 2*vx1*vy2*x1*y1 + 2*vx1*vy2*x1*y2 + 2*vx1*vy2*x2*y1 - 2*vx1*vy2*x2*y2 - vx2^2*y1^2 + 2*vx2^2*y1*y2 - vx2^2*y2^2 - 2*vx2*vy1*x1*y1 + 2*vx2*vy1*x1*y2 + 2*vx2*vy1*x2*y1 - 2*vx2*vy1*x2*y2 + 2*vx2*vy2*x1*y1 - 2*vx2*vy2*x1*y2 - 2*vx2*vy2*x2*y1 + 2*vx2*vy2*x2*y2 - vy1^2*x1^2 + 2*vy1^2*x1*x2 - vy1^2*x2^2 + 2*vy1*vy2*x1^2 - 4*vy1*vy2*x1*x2 + 2*vy1*vy2*x2^2 - vy2^2*x1^2 + 2*vy2^2*x1*x2 - vy2^2*x2^2)^(1/2) - vx1*x1 + vx1*x2 + vx2*x1 - vx2*x2 - vy1*y1 + vy1*y2 + vy2*y1 - vy2*y2)/(vx1^2 - 2*vx1*vx2 + vx2^2 + vy1^2 - 2*vy1*vy2 + vy2^2);
    
    if abs(t1) >= dtc
        dtc = abs(t1);
    end
end

