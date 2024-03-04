function [q] = transform_conic_alg(q, T)
 
q = conic_to_alg( transform_conic(alg_to_conic(q), T) ) ;
 
end