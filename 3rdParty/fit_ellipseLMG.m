function [ParG,RSS,iters] = fit_ellipseLMG(XY,ParGini,LambdaIni)

%--------------------------------------------------------------------------
% Fitting an ellipse to a given set of points (Implicit method)
% using geometric parameter
%
% This is generated by us using implicit differentiation for computing
% Jacobian matrix.
% Minimization scheme: Levenberg-Marquardt
%
% Input
% XY:given points<XY(i,1),XY(i,2)> i=1 to n
% ParGini = [Center(1:2), Axes(1:2), Angle]'
% LambdaIni:the initial value of the control parameter Lambda

% Output
% ParG: parameter vector of the ellipse found
% RSS: the Residual Sum of Squares (the sum of squares of the distances)
% iters:# of iterations
%
% Copyright 2011 Hui Ma
%--------------------------------------------------------------------------

if (nargin < 3), LambdaIni = 1; end;  % if Lambda(initial) is not supplied, set it to one

epsilon=0.000001;    % tolerance (small threshold)
IterMAX = 100;        % maximal number of (main) iterations; usually 10-20 suffice 
lambda_sqrt = sqrt(LambdaIni);   %  sqrt(Lambda) is actually used by the code

[F, XYproj] = Residuals_ellipse(XY,ParGini);
[Res,J] = JmatrixLMG(XY,ParGini,XYproj);
ParG = ParGini;

for iter=1:IterMAX         %  main loop, each run is one (main) iteration

    while (1)         %  secondary loop - adjusting Lambda (no limit on cycles)

        DelPar = [J; lambda_sqrt*eye(5)]\[-Res; zeros(5,1)];   % step candidate
        progress = norm(DelPar)/(norm(ParG)+epsilon);
        if (progress < epsilon)  break;  end;               % stopping rule
        ParTemp = ParG + DelPar;
        if (ParTemp(3)< ParTemp(4))        %   out of range
            Temp=ParTemp(3);
            ParTemp(3)=ParTemp(4);
            ParTemp(4)=Temp;
            ParTemp(5)=ParTemp(5)-sign(ParTemp(5))*pi/2;
        end
        [FTemp, XYprojTemp] = Residuals_ellipse(XY,ParTemp);
        
        if (FTemp < F && ParTemp(3)>0 && ParTemp(4)>0)        %   yes, improvement
           lambda_sqrt = lambda_sqrt/2;   % reduce lambda, move to next iteration
           break;
        else                            %   no improvement
           lambda_sqrt = lambda_sqrt*2; % increase lambda, recompute the step
           continue;
        end
    end   %   while (1), the end of the secondary loop

    if (progress < epsilon)  break;  end;             % stopping rule
    [Res,J] = JmatrixLMG(XY,ParTemp,XYprojTemp);
    ParG = ParTemp;  F = FTemp;  % update the iteration
end    

RSS = F;
iters = iter;

% make the angle parameter between 0 and pi
while(ParG(5) >= pi)
    ParG(5) = ParG(5) - pi;
end

while(ParG(5) < 0)
    ParG(5) = ParG(5) + pi;
end

end   


%================ function JmatrixLMG ====================================


function [Res,J] = JmatrixLMG(XY,A,XYproj)

%Compute the Jacobian matrix(Implicit method)using geometric parameter
%Input:  XY: given n points <XY(i,1),XY(i,2)> i=1 to n
%        XYproj: corresponding n projection points on the conic
%        A: parameter vector of the ellipse found
%
%Output: Res: the squared error distances vector
%        J: Jacobian martrix


n=size(XY,1);Res = zeros(n,1);

s=sin(A(5)); c=cos(A(5));
ss=s*s;cc=c*c;cs=c*s;

a=A(3);b=A(4);
aa=a^2;bb=b^2;ba=bb-aa;

DD=XY-XYproj;
D1=[XYproj(:,1)-A(1) XYproj(:,2)-A(2)];
D2=[D1(:,2) D1(:,1)];

for i=1:n
    Res(i) = sign(DD(i,:)*D1(i,:)')*norm(DD(i,:));
end

du=D1*[bb*cc+aa*ss;cs*ba];
dv=D2*[bb*ss+aa*cc;cs*ba];

D3=[D1(:,1).^2 D1(:,2).^2 D1(:,1).*D1(:,2) ones(n,1)];
d3= D3*[ss;cc;-2*cs;-bb]*a;
d4= D3*[cc;ss;2*cs;-aa]*b;
d5= D3*[-ba*cs;ba*cs;ba*(cc-ss);0];
e =sqrt(du.^2+dv.^2);
J=[-du./e -dv./e d3./e d4./e d5./e];

end

   






