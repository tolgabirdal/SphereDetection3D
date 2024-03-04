function [ParG, code] = AtoEllipse (ParA)
 
%  Conversion of Algebraic parameters of a conic to its Geometric parameters
 
%   Algebraic parameters are coefficients A,B,C,D,E,F in the algebraic
%   equation     Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
 
%   Geometric parameters depend on the type of the conic (ellipse, etc.)
 
%   Input:  ParA = (A,B,C,D,E,F)' is the vector of Algebraic parameters
 
%   Output: ParG is the vector of Geometric parameters (see below)
 
%           Geometric parameters are determined only for
%               the most common types of conics:
 
%   1. Ellipses:  canonical equation  x^2/a^2 + y^2/b^2 = 1
%                 a>b or a=b are the major and minor semi-axes
 
%       ParG = [Xcenter, Ycenter, a, b, AngleOfTilt]'
%        Nikolai Chernov,  February 2012
 
ParA(2)=ParA(2)/2;
ParA(4)=ParA(4)/2;
ParA(5)=ParA(5)/2;
 ParA=ParA/norm(ParA);    %  normalize the given algebraic parameter vector
 
ParG = -1;   %  this will be returned for imaginary or degenerate conics
M22 = [ParA(1) ParA(2);
    ParA(2) ParA(3)];           %  small, 2x2 matrix
 
%          Next: non-degenrate types of conics
[Q, D] = eig(M22);    %  eigendecomposition
 
U  = Q'*[ParA(4); ParA(5)];       %  orthogonal transformation
 
Uc = -U./diag(D);
Center = Q*Uc;
H = -U'*Uc - ParA(6);
 
if (H*D(1,1) <= 0)
    code = 9;                     %  imaginary ellipse
else
    code = 1;                        %   ellipse
    a = sqrt(H/D(1,1));
    b = sqrt(H/D(2,2));
    Angle = atan2(Q(2,1), Q(1,1));
    if (Angle < 0),  Angle = Angle + pi;    end
    if a < b      %  making sure that a is major, b is minor
        ab = a; a = b; b = ab;
        Angle = Angle - pi/2;
        if (Angle < 0),  Angle = Angle + pi;  end
    end
    ParG = [Center; a; b; Angle];
end
 
end    %  end of function AtoG