
function [lambda, valid] = update_sphere_fit(xParticular, nullSpace, AK)
	bnew = -dot(AK,xParticular);
	AKnull = dot(AK,nullSpace);
	lambda = bnew./AKnull;
	valid = (abs(AKnull) > eps);
end
