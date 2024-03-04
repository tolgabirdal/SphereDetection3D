function [nullSpace, xParticular] = null_sol(A, b)
if(rank(A)==4)
    xParticular = A\b;
    nullSpace = null(A);
else
    nullSpace = [];
    xParticular = [];
end
end
