function particleArray = moveObjectsGravity(particleArray,dt,g)

for k = 1:length(particleArray)
        particleArray(k).x = particleArray(k).x + dt*particleArray(k).vx;
        particleArray(k).y = particleArray(k).y + dt*particleArray(k).vy - (g / 2) * dt^2;
        particleArray(k).vy = particleArray(k).vy - g*dt;
end
