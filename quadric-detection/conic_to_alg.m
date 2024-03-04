function [x] = conic_to_alg(Q)
 
A=Q(1,1);
B=Q(2,2);
C=Q(1,2);
D=Q(1,3);
E=Q(2,3); 
F=Q(3,3); 
x = [A,B,2*C,2*D,2*E,F];
 
end