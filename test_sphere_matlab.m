clc;
clear all;
close all;

add_libs;

maxDistance = 0.2;
maxDistanceSphere = 0.05;
referenceVector = [0,0,1];
maxAngularDistance = 20;

load('object3d.mat');

X = reshape(ptCloud.Location, 640*480, 3);
C = reshape(ptCloud.Color, 640*480, 3);
ptCloud = pointCloud(X);
ptCloud.Color = C;

roi = [-inf,0.5,0.2,0.4,0.1,inf];
sampleIndices = findPointsInROI(ptCloud,roi);
[model,inlierIndices] = pcfitsphere(ptCloud,maxDistance,...
            'SampleIndices',sampleIndices);
globe = select(ptCloud,inlierIndices);
figure, pcshow(globe);
hold on, draw_sphere(model.Center, model.Radius);
title('How it should look like:');
drawnow;
%figure, pcshow(globe);
%title('How the detection looks:');
%drawnow;
c0 = model.Center' + 0.015*randn(3,1);
r0 = model.Radius + 0.015*randn(1,1);
alpha = 1.8;
sigma = 0.05;

% detect sphere
relSampling = 0.1;
numQuantBins = 60;
maxDist = 0.1;
meanShiftBandwidth = 0.1;
center = [0 0 0.5];
[globeNormals, ~] = compute_pc_normals_flip(globe, 51,center);
figure,pcshow(globeNormals);
globeX = globeNormals.Location;
globeN = globeNormals.Normal;
ind = 1:10:length(globeX);
% hold on, quiver3(globeX(ind,1), globeX(ind,2), globeX(ind,3), globeX(ind,1)+globeN(ind,1), globeX(ind,2)+globeN(ind,2), globeX(ind,3)+globeN(ind,3), 5);
[centers, radii, finalScores] = detect_spheres_pc(globeNormals, relSampling, maxDist, numQuantBins, meanShiftBandwidth);

c0 = centers(1,:)';
r0 = radii(1,:);
hold on, draw_sphere(c0,r0);
title('How the detection looks:');


% do alpha stable
% relSampling = 0.05;
% numPoints = 1000;
% ptCloudA = PointCloudUtils(0.0, double(globe.Location'), relSampling, numPoints);
% ptCloudA = ptCloudA';
% disp(['Downsampled to ' num2str(length(ptCloudA)) ' points.']);
% [c, r] = fit_sphere_alpha_stable(ptCloudA, c0, r0, alpha, sigma, 1000, 0.001, 1, globe);

