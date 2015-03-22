function P = MakeParticle(x,y,xvel,yvel,radius,mass,ID)
%Each particle has: x position, y position, x velocity, y velocity, radius
%and mass
P = struct('x',x,'y',y,'vx',xvel,'vy',yvel,'r',radius,'m',mass,'ID',ID);