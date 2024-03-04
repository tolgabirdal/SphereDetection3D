
function [lambda] = update_null_sol_sphere(xParticular, nullSpace, AK)
	bnew = -AK*xParticular;
	AKnull = AK'*nullSpace;
	AKnull = AKnull./dot(AKnull,AKnull,1);
	lambda = dot(AKnull, bnew);
end