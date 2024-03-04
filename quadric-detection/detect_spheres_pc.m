% ptCloud is expected to have surface normals
% relSampling is used to downsample the point cloud. smaller values lead to
% more samples.
% points that are further away than maxDist are not paired to form bases
% numQuantBins is used to quantize lambda. 
% meanShiftBandwidth is used for final clustering afterwards
function [centers, radii, finalScores] = detect_spheres_pc(ptCloud, relSampling, maxDist, numQuantBins, meanShiftBandwidth)

% I assume normals are computed.
%pcNormals = compute_pc_normals(ptCloud, 13);

%ptCloudA = PointCloudUtils(1.0, double(globe.Location'), double(pcNormals'), relSampling, numPoints);
%ptCloudA = ptCloudA';
if (relSampling>0)
    ptCloudA = pcdownsample(ptCloud, 'gridAverage', relSampling);
    disp(['Downsampled to ' num2str(length(ptCloudA.Location)) ' points.']);
else
    ptCloudA = ptCloud;
end

minPt = [ptCloudA.XLimits(1) ptCloudA.YLimits(1) ptCloudA.ZLimits(1)];
maxPt = [ptCloudA.XLimits(2) ptCloudA.YLimits(2) ptCloudA.ZLimits(2)];
diam = norm(maxPt-minPt);

pcwrite(ptCloudA, 'output/pcwrite.ply');

ptCloudA = [ptCloudA.Location ptCloudA.Normal];
N = length(ptCloudA);

spheres = [];
scores = [];
weightPoints = 5.0;
weightNormals = 1.0;
quantizer = numQuantBins / 360.0;
%figure;

for i=1:N
    
    x = ptCloudA(i, 1:3)';
    n = ptCloudA(i, 4:6)';
    % TODO: The brilliant GridAvg leaves the normals unnormalized.
    % precompute this for speed. 
    n = n./norm(n); 
    [A, b] = form_sphere_system(x, n, weightPoints, weightNormals);
    [nullSpace, qParticular] = null_sol(A, b);
    
    accum = zeros(numQuantBins+1,1);
    lambdaBins = zeros(numQuantBins+1,1);
    numSolutions = 0;
    
    for j=1:N
        y = ptCloudA(j, 1:3)';
        if (i==j || norm(x-y)>maxDist)
            continue;
        end
        
        AK = weightPoints*[dot(y,y), y(1), y(2), y(3), 1]';
        bnew = -dot(qParticular,AK);
        AKnull = dot(AK, nullSpace);
        lambda = bnew / AKnull;
        
        %currentSphereCandidate = lambda.*nullSpace + qParticular;
        
        % TODO : Implement normal checking
        %if ((currentSphereCandidate.gradient(p2).normalized().dot(n2)) > 0.85 && currentSphereCandidate.center.z()>0.5)
        
        if (true)
            x1 = nullSpace(1);
            x2 = nullSpace(2);
            b1 = qParticular(1);
            b2 = qParticular(2);
            y1 = b1 + lambda *x1;
            y2 = b2 + lambda *x2;
            theta = atan2(y2 - y1, x2 - x1);
            theta = rad2deg(theta + pi);
            voteBin = int32(theta*quantizer)+1;
            accum(voteBin) = accum(voteBin)+1;
            lambdaBins(voteBin) = lambdaBins(voteBin) + lambda;
            numSolutions = numSolutions+1;
        end
    end
       
    if (numSolutions < 4)
        continue;
    end
    
    bestBin = 1;
    score = 0;
    for l = 1:length(accum)
        curPdf = accum(l);
        if (curPdf > score)
            score = curPdf;
            bestBin = l;
        end
    end
    
    if (score <= 4)	% do not generate quadrics for insufficient votes (local scores)
        continue;
    end
        
    bestLambda = lambdaBins(bestBin)/ accum(bestBin);   
    curSphere = bestLambda.*nullSpace + qParticular;
    spheres = [spheres; curSphere'];
    scores = [scores; score];

%      if (mod(i,int32(N/6))==0)
%         hold on, plot(accum);
%     end
end

% convert to geometric representation
[centers, radii] = q2cr(spheres);
CR = [centers radii];

[~,idx,~] = MeanShiftCluster(centers',meanShiftBandwidth, 0);
numClusters = max(idx);
finalScores = zeros(numClusters, 1);
bestFits = zeros(numClusters, 4);
for clus=1:numClusters % for each class
    ind = find(idx==clus);
    scoresCluster = scores(ind);
    members = CR(ind, :);
    for j=1:4 % for each component of the sphere record the median
        bestFits (clus, j) = median(members(:,j));
    end
    finalScores(clus) = sum(scoresCluster);
end

A = [finalScores bestFits];
A = sortrows(A,'descend');
centers = A(:,2:4);
radii = A(:,5);
finalScores = A(:,1);

end
