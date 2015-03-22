function particleArray = moveObjects(particleArray,dt)

for k = 1:length(particleArray)
    particleArray(k).x = particleArray(k).x + dt*particleArray(k).vx;
    particleArray(k).y = particleArray(k).y + dt*particleArray(k).vy;
end

