function [Q] = transform_conic(Q, affine) 
 
Q = inv(affine)'*Q*inv(affine);
 
end