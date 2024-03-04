function [A, b] = form_sphere_system(point, normal, weightPoints, weightNormals)
A = [weightPoints*dot(point,point), weightPoints*point', weightPoints;
    2 * weightNormals * point(1), weightNormals, 0, 0, 0;
    2 * weightNormals * point(2), 0, weightNormals, 0, 0;
    2 * weightNormals * point(3), 0, 0, weightNormals, 0];
b = zeros(size(A,1),1);
b(end-2:end) = weightNormals*normal;
end
