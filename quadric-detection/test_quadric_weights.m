
weightPoints = 0.01:0.1:1;
weightNormals = 1-weightPoints;


[c, lambda] = fit_conic_birdal_sturm(x, y, gx, gy, weightPoints, weightNormals);