function [q, nullSpace, A] = fit_conic_birdal_under(x, y, gx, gy, weightPoints, weightNormals)

x = double(x(:)); gx = double(gx(:));
y = double(y(:)); gy = double(gy(:));
 
l = ones(numel(x), 1);
o = zeros(numel(x), 1);
X = [x.^2, y.^2, x.*y, x, y, l];
dX = [2*x, o, y, l, o, o; ...
      o, 2*y, x, o, l, o];
N = [gx; gy];
A = [weightPoints*X; weightNormals*dX];
b = [zeros(numel(x), 1); weightNormals*N];
q = A\b;

[nullSpace, q] = null_sol(A, b);
 
q = q./norm(q);

end