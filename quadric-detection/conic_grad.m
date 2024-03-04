function [nablaCx] = conic_grad(C, x)

nabla = 2*[C(1,:); C(1,2), C(2,2), C(2,3)];
nablaCx = nabla*[x ones(length(x),1)]';
nablaCx = nablaCx';
end