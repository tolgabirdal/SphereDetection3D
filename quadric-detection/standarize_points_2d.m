function [X, T] = standarize_points_2d(X)
% standarize the point set to unit ball 
% T maps the transformed space to original one 
 
% center it
mu = mean(X, 1);
X = X - repmat(mu, size(X,1), 1);
 
maxX = max(X, [], 1);
minX = min(X, [], 1);
 
d = norm(maxX - minX);
 
X = X./d;
 
T = eye(3);
T(1:2, 3) = mu';
T(1:2, 1:2) = diag([d d]);
 
end