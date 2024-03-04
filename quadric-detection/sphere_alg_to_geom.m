function [center, radius] = sphere_alg_to_geom(q)

if (size(q,1)==1 || size(q,2)==1)
    c = q(1);
    center = -0.5* q(2:4) ./ c;
    radius = sqrt(abs(norm(center).^2 - q(5) / c));
else
    for i=1:size(q,2)
        [c, r] = sphere_alg_to_geom(q(i,:));
        center = [center; c];
        radius = [radius r];
    end
end

end