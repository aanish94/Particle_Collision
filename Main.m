clc
clear all
close all

%%%%%%%%%%%%%%%%%%
%FUNCTIONS NEEDED%
%%%%%%%%%%%%%%%%%%

% MakeParticle (check)
% moveObjects (check)
% moveObjectsGravity (check)
% moveObjectsBrownian (check)
% Collision_Detection (check)
% Collision_Times (check)
% Reverse_Velocity (check)
% CreateAABBArray (check)

%%%%%%%%%%%%%%%%%%%%%%%%
%INITIALIZE PARAMETERS %
%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Number of Objects %%%%%
numObj = 10;
%%%% Load Data From File %%%%%
load('SAP1.mat')
% systemWidth = 100;
% systemHeight = 100;
%%%% Create random starting positions %%%%%
positions = rand(numObj,2);
positions(:,1) = positions(:,1) * systemWidth;
positions(:,2) = positions(:,2) * systemHeight;
%%%% Randomized x and y velocities %%%%%
max_velocity = 10;
xvelocities = (rand(numObj,1) - 0.5) * max_velocity;
yvelocities = (rand(numObj,1) - 0.5) * max_velocity;
%%%% Constant Density (if you want mass and radius to be proportional)
rho = 2;
%%%% Randomized mass %%%%
max_mass = 100;
min_mass = 1;
mass = min_mass + (rand(numObj,1)) * max_mass;
%%%% Randomized radius %%%%
max_radius = 5;
min_radius = 1;
% radius = min_radius + (rand(numObj,1)) * max_radius;
radius = sqrt(mass / (rho*pi));
%%%% Create Structure Array of Particles %%%%
for index = 1:numObj
    particleArray(index) = MakeParticle(positions(index,1),positions(index,2),xvelocities(index),yvelocities(index),radius(index),mass(index),index);
end

%Time step
dt = 0.1;
%Total time
t_final = 100;

%%%%% Configuring Figure %%%%%
figure(1)
% figure('visible','off')
axis equal
axis([0 systemWidth 0 systemHeight])
box on
xlabel('x','FontSize',16)
ylabel('y','FontSize',16)
title('Advanced Collision Dynamics Simulator','FontSize',14)
text((systemWidth/10),systemHeight - (systemHeight/20),'Aanish Patel Sikora: Amazing Collision Simulator')
%%%%%%%%%%%%%%%%%
%BONUS FEATURES %
%%%%%%%%%%%%%%%%%

%%%%% TOTAL STARS = 23 stars %%%%%
%-----Gravity (*)
gravity = 0; % 1 = ON, 0 = OFF
g = 0.5; %PLUTO's g.  
%-----Inelastic Collisions (*)
inelastic = 0; % 1 = ON, 0 = OFF
e = 0.6; %Coefficient of Restitution 
%-----Brownian Dynamics (**)
brownian = 0;
D = .0001;
r_brown = randn(numObj,2);
%-----Heterogenous disk mass (**)
%-----Heterogenous disk radius (***)
%-----Periodic Boundary Conditions (***)
periodic = 0; % 1 = ON, 0 = OFF
%-----Write report in LATEX (***)
%-----Fancy Data Structures (****)
%-----Particle source/sink (****)
sink = 0; % 1 = ON, 0 = OFF

%%%%%%%%%%%%
%TIME STEP %
%%%%%%%%%%%%

k = 1;
t = 0;
%%%%% CREATE VIDEO %%%%%
% writerObj = VideoWriter('CollisionAnimation','MPEG-4');
% writerObj.FrameRate = 60;
% writerObj.Quality = 100;
% open(writerObj);
colors = ['r' 'g' 'b' 'c' 'm' 'y'];
circlefigures = zeros(1,numObj);
for zz = 1:numObj
    color = mod(zz,6) + 1;
    x_min = particleArray(zz).x - particleArray(zz).r;
    y_min = particleArray(zz).y - particleArray(zz).r;
    radius_cur = particleArray(zz).r;
    circlefigures(zz) = rectangle('Position',[x_min,y_min,2*radius_cur,2*radius_cur],'Curvature',[1 1], 'FaceColor',colors(color));
end

%%%%% BEGIN TIME STEPPING %%%%%
while t < t_final
    %%%%% PREDICT NEW POSITIONS %%%%%
    if brownian == 1 %BROWNIAN
        sink = 1;
        particleArray = moveObjectsBrownian(particleArray,dt,D,r_brown);
    elseif gravity == 1 %GRAVITY
        particleArray = moveObjectsGravity(particleArray,dt,g);
    else %NORMAL
        particleArray = moveObjects(particleArray,dt);
    end
    %%%%% INCREMENT TIME %%%%%
    t = t + dt;
    %%%%% CHECK FOR COLLISIONS %%%%%
    collisions = Collision_Detection(particleArray,systemWidth,systemHeight);
    if ~isempty(collisions)
        %%%%% COMPUTE REVERSE TIME INCREMENT TO FIRST COLLISION %%%%%
        dtc = Collision_Times(collisions);
        %%%%% CORRECT POSITIONS TO FIRST COLLISION %%%%%
        if gravity == 1 %GRAVITY
            particleArray = moveObjectsGravity(particleArray,-dtc,g);
        elseif brownian == 1 %BROWNIAN
            particleArray = moveObjects(particleArray,-dtc);
        else %NORMAL
            particleArray = moveObjects(particleArray,-dtc);
        end
        %%%%% CORRECT VELOCITIES %%%%%
        for j = 1:length(collisions(:,1))
            ID1 = collisions(j,1).ID;
            ID2 = collisions(j,2).ID;
            [dvx1,dvy1,dvx2,dvy2] = Reverse_Velocity(collisions(j,1),collisions(j,2),inelastic,e);
            particleArray(ID1).vx = dvx1;
            particleArray(ID1).vy = dvy1;
            particleArray(ID2).vx = dvx2;
            particleArray(ID2).vy = dvy2;
        end
        %%%%% INCREMENT TIME %%%%%
        t = t - dtc;
    end
    %%%%% BOUNDARY COLLISIONS %%%%%
    flag_delete = 0;
    for index = 1:numObj
        x = particleArray(index).x;
        y = particleArray(index).y;
        max_x = x + particleArray(index).r;
        min_x = x - particleArray(index).r;
        max_y = y + particleArray(index).r;
        min_y = y - particleArray(index).r;
        %%%%% PERIODIC BOUNDARY CONDITIONS %%%%%
        if periodic == 1
            if min_x <= 0 && particleArray(index).vx < 0
                particleArray(index).x = particleArray(index).x + systemWidth;
            elseif max_x >= systemWidth && particleArray(index).vx > 0
                particleArray(index).x = particleArray(index).x - systemWidth;
            end
            
            if min_y <= 0 && particleArray(index).vy < 0
                particleArray(index).y = particleArray(index).vy + systemHeight;
            elseif max_y >= systemHeight && particleArray(index).vy > 0
                particleArray(index).y = particleArray(index).y - systemHeight;
            end
            %%%%% SINK BOUNDARY CONDITIONS %%%%%
        elseif sink == 1
            if min_x <= 0 && particleArray(index).vx < 0
                index_delete = index;
                flag_delete = 1;
            elseif max_x >= systemWidth && particleArray(index).vx > 0
                index_delete = index;
                flag_delete = 1;
            end
            
            if min_y <= 0 && particleArray(index).vy < 0
                index_delete = index;
                flag_delete = 1;
            elseif max_y >= systemHeight && particleArray(index).vy > 0
                index_delete = index;
                flag_delete = 1;
            end
            %%%%% NORMAL BOUNDARY CONDITIONS %%%%%
        else
            if min_x <= 0 && particleArray(index).vx < 0
                particleArray(index).vx = -particleArray(index).vx;
            elseif max_x >= systemWidth && particleArray(index).vx > 0
                particleArray(index).vx = -particleArray(index).vx;
            end
            
            if min_y <= 0 && particleArray(index).vy < 0
                particleArray(index).vy = -particleArray(index).vy;
            elseif max_y >= systemHeight && particleArray(index).vy > 0
                particleArray(index).vy = -particleArray(index).vy;
            end
        end
    end
    
    %%%%% FOR SINK BOUNDARY CONDITIONS %%%%%
    if flag_delete == 1
        beg = 1:index_delete-1;
        back = index_delete+1:numObj;
        indexes_to_keep = horzcat(beg,back);
        
        for bb = index_delete:numObj
            particleArray(bb).ID = particleArray(bb).ID - 1;
        end
        particleArray = particleArray(indexes_to_keep);
        delete(circlefigures(index_delete));
        circlefigures = circlefigures(indexes_to_keep);
        numObj = numObj - 1;
    end
    %%%%% PLOT PARTICLES %%%%%
    for zz = 1:numObj 
        color = mod(zz,6) + 1;
        x_min = particleArray(zz).x - particleArray(zz).r;
        y_min = particleArray(zz).y - particleArray(zz).r;
        radius_cur = particleArray(zz).r;
        
        set(circlefigures(zz),'Position',[x_min,y_min,2*radius_cur,2*radius_cur],'Curvature',[1 1], 'FaceColor',colors(color));
    end
    if k > 1
        delete(l)
    end
    l = text(5,5,sprintf('t=%3.2f',t),'FontSize',18);
    drawnow
%     frame = getframe;
%     writeVideo(writerObj,frame);
    k = k + 1;
end
% close(writerObj);
