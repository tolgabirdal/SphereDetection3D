% Quadric fitting using Birdal's method:
% Points and normals : x, y, z, nx, ny, nz
% standarize: demean and scale the point set first ? 
% lambdaPoints / lambdaNormals : A balance between point/normal bias
function [q, lambda] = fit_conic_birdal_full(x, y, nx, ny, standarize, weightPoints, weightNormals, displayInfo)
 
validateattributes(x, {'numeric'}, {'real','nonempty','vector'});
validateattributes(y, {'numeric'}, {'real','nonempty','vector'});
validateattributes(nx, {'numeric'}, {'real','nonempty','vector'});
validateattributes(ny, {'numeric'}, {'real','nonempty','vector'});
 
if (~exist('lambdaPoints', 'var')) weightPoints = 5; end
if (~exist('lambdaNormals', 'var')) weightNormals = 0.5; end
if (~exist('display', 'var')) displayInfo = 1; end
 
x = double(x(:)); nx = double(nx(:));
y = double(y(:)); ny = double(ny(:));
 
if (standarize)
    X = [x y];
    [X, M] = standarize_points_2d(X);
    x = X(:,1); y = X(:,2);
end
 
%auxiliary variables
m = numel(x);
l = ones(m,1);
o = zeros(m,1);
n = numel(x);

X = [x.^2, y.^2, x.*y, x, y, l zeros(numel(x), n)];
dX = [2*x, o, o, y, l, o, o; ...
      o, 2*y, o, x, o, l, o];
NdX = [diag(nx); diag(ny)];
A = [weightPoints*X; weightNormals*[dX -NdX]];
[~,~,V] = svd((A));
sol = V(:, end);
% sol=null(A);
% sol = sol(:, end);
lambda = sol(11:end);
q = sol(1:10);
 
%[q2, lambda2] = fit_quadric_birdal_sturm(x, y, z, nx, ny, nz, weightPoints, weightNormals);
 
if (displayInfo)
    disp(['rank is ' num2str(rank(A))]);
    disp(['condition A ' num2str(cond(A))]);
    disp(['error: ' num2str(norm(A*sol))])
end
 
if (standarize)
    q = transform_conic_alg(q, M);
end
 
q = q./norm(q);
 
end