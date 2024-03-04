% computes normals of pc and flips them towards the old normals in pc.
% it is required that pc has Normal field before call to this function.
function [pcn, theta] = compute_pc_normals_dir(pc, NN)
 
normals1 = pc.Normal;
pcn = pointCloud(pc.Location);
normals2 = pcnormals(pcn, NN);
 
theta = (vangle2(normals1, normals2));
ind = (theta>pi/2);
normals2(ind, :) = -normals2(ind, :);
 
theta = (vangle2(normals1, normals2));
 
pcn.Normal = normals2;
 
end