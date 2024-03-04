clc;
clear all;
close all;

add_libs;

folder = './datasets/spheres-pc';
%fn = [folder '/0000233-000007741666.ply'];
fn = [folder '/0000001-000000000000 (1).ply'];

ptCloud = pcread(fn);

roi = [-inf,inf,-inf,inf,-2, 0];
sampleIndices = findPointsInROI(ptCloud,roi);
pts = select(ptCloud,sampleIndices);
figure, pcshow(ptCloud);
drawnow;

% detect sphere
relSampling = 0.1;
numQuantBins = 60;
maxDist = 0.1;
meanShiftBandwidth = 0.1;
center = [0 0 0];
[ptsNormals, theta] = compute_pc_normals_flip(pts, 21, center);
figure,pcshow(ptsNormals);
% globeX = ptsNormals.Location;
% globeN = ptsNormals.Normal;
% ind = 1:100:length(globeX);
% hold on, quiver3(globeX(ind,1), globeX(ind,2), globeX(ind,3), globeX(ind,1)+globeN(ind,1), globeX(ind,2)+globeN(ind,2), globeX(ind,3)+globeN(ind,3), 15);
[centers, radii, finalScores] = detect_spheres_pc(ptsNormals, relSampling, maxDist, numQuantBins, meanShiftBandwidth);

c0 = centers(1,:)';
r0 = radii(1,:);
hold on, draw_sphere(c0,r0);
title('How the detection looks:');

