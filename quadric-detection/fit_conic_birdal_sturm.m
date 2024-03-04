function [c, lambda] = fit_conic_birdal_sturm(x, y, gx, gy, weightPoints, weightNormals)
n = numel(x);
l = ones(n, 1);
o = zeros(n, 1);
NdX = -[diag(gx); diag(gy)];
X = [x.^2, y.^2, x.*y, x, y,l zeros(n, n)];
dX = [2*x, o, y, l, o, o; ...
      o, 2*y, x, o, l, o];
A = [weightPoints*X; weightNormals*[dX NdX]];
[~,~,V] = svd(A);
%q = null(A);
%q = q(:,end);
c = V(:, end);
lambda = c(11:end);
c = c(1:10);
end