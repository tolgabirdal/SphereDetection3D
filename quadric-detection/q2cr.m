function [center, radius] = q2cr(q)

c = q(:,1); % mean is taken due to numerical issues
center = -0.5* q(:,2:4) ./ repmat(c,1,3);
radius = sqrt(abs(dot(center,center,2) - q(:,5) ./ c));

end

% centers = spheres(:, 2:4);
% radii = sqrt(abs(dot(centers,centers,2) - spheres(:, 5).*spheres(:, 5)));