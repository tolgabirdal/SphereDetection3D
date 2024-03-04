function draw_sphere(center, radius)
r = radius;
[x,y,z] = sphere(20);
surf(x*r+center(1), y*r+center(2), z*r+center(3));
end