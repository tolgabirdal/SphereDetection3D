
function spheres = cluster_spheres_agglomerative(spheres, qPars, threshold)
end

% 	int n = std::min((int)spheres.size(), pars.numMaxClusteredQuadrics);
% 	std::vector<TSphereCluster> clusters;
% 	clusters.clear();
% 
% 	std::sort(spheres.begin(), spheres.end(), sortQuadricFunctor);
% 
% 	for (int i = 0; i < n; i++) {
% 		TSphere &quadric = spheres[i];
% 		bool assigned = false;
% 
% 		// search all clusters
% 		for (int j = 0; j < clusters.size() && !assigned; j++) {
% 			TSphere* quadricCenter = static_cast<TSphere*>(clusters[j].quadrics[0]);
% 			if (quadricCenter->distance(quadric) < threshold)
% 			{
% 				clusters[j].addQuadric(&quadric);
% 				assigned = true;
% 			}
% 		}
% 
% 		if (!assigned) {
% 			clusters.push_back(TSphereCluster(&quadric));
% 		}
% 		// if (pars.verbose)
% 		// 	std::cout << "n: " << n << ", i: " << i << ", num clusters: " << clusters.size() << std::endl;
% 	}
% 
% 	return clusters;
