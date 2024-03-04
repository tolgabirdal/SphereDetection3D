function [pc, theta] = compute_pc_normals_flip(pc, NN, center)
 
normals = pcnormals(pc, NN);

theta = (vangle2(normals, repmat(center,length(pc.Location),1)-pc.Location));
ind = (theta>pi/2);
normals(ind, :) = -normals(ind, :);
 
theta = (vangle2(normals, -pc.Location));
 
pc.Normal = single(normals);
 
end