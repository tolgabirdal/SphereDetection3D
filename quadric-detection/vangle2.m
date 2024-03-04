function [theta] = vangle2(a,b)
 
na = sqrt(dot(a,a,2));
nb = sqrt(dot(b,b,2));
x = bsxfun(@times, a, nb);
y = bsxfun(@times, b, na);
diff =x-y;
add = x+y;
ndiff = sqrt(dot(diff,diff,2));
nadd = sqrt(dot(add,add,2));
theta = 2.*atan(ndiff./nadd);
 
a=a(1,:);
b=b(1,:);
% 
% na = norm(a);
% nb = norm(b);
% x=nb.*a;
% y=na.*b;
% diff =x-y;
% add = x+y;
% theta = 2*atan(norm(diff)/norm(add));
% %theta = 2 * atan(norm(x*norm(y) - norm(x)*y) / norm(x * norm(y) + norm(x) * y));
 
end