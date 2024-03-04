function draw_plane(v, x)

x1=x(1);
y1=x(2);
z1=x(3);

w = null(v); % Find two orthonormal vectors which are orthogonal to v
[P,Q] = meshgrid(-3:0.1:3); % Provide a gridwork (you choose the size)
X = x1+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
Y = y1+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
Z = z1+w(3,1)*P+w(3,2)*Q;
surf(X,Y,Z)

end
