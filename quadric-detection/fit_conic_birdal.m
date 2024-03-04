function q = fit_conic_birdal(x, y, gx, gy, weightPoints, weightNormals, standarize)

validateattributes(x, {'numeric'}, {'real','nonempty','vector'});
validateattributes(y, {'numeric'}, {'real','nonempty','vector'});
validateattributes(gx, {'numeric'}, {'real','nonempty','vector'});
validateattributes(gy, {'numeric'}, {'real','nonempty','vector'});
 
if (~exist('weightPoints', 'var')) weightPoints = 5; end
if (~exist('weightNormals', 'var')) weightNormals = 0.5; end
if (~exist('display', 'var')) displayInfo = 1; end
 
x = double(x(:)); gx = double(gx(:));
y = double(y(:)); gy = double(gy(:));
 
if (standarize)
    X = [x y];
    [X, M] = standarize_points_2d(X);
    x = X(:,1); y = X(:,2);
end

l = ones(numel(x), 1);
o = zeros(numel(x), 1);
X = [x.^2, y.^2, x.*y, x, y, l];
dX = [2*x, o, y, l, o, o; ...
      o, 2*y, x, o, l, o];
N = [gx; gy];
A = [weightPoints*X; weightNormals*dX];
b = [zeros(numel(x), 1); weightNormals*N];
q = A\b;
rank(A);

if (displayInfo)
    disp(['rank is ' num2str(rank(A))]);
    disp(['condition A ' num2str(cond(A))]);
    disp(['error: ' num2str(norm(A*q))])
end
 
if (standarize)
    q = transform_conic_alg(q, M);
end

q = q./norm(q);
 
end