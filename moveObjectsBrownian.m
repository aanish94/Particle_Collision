function particleArray = moveObjectsBrownian(particleArray,dt,D,r_brown)

for k = 1:length(particleArray)
        particleArray(k).x = particleArray(k).x + dt*particleArray(k).vx + sqrt(2*D*dt) * r_brown(k,1);
        particleArray(k).y = particleArray(k).y + dt*particleArray(k).vy + sqrt(2*D*dt) * r_brown(k,2);;
    
        particleArray(k).vx = sqrt(2*D*dt) * r_brown(k,1) / dt + particleArray(k).vx;
        particleArray(k).vy = sqrt(2*D*dt) * r_brown(k,2) / dt + particleArray(k).vy;
        
end
