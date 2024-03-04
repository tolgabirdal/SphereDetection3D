function [u] = DrawEllipse(C,a,b,alpha)
% DRAWELLIPSE plots an ellipse
%   DrawEllipse(C,a,b,alpha) plots ellipse with center C, semiaxis a
%   and b and angle alpha between a and the x-axis

s=sin(alpha); c=cos(alpha);
Q =[c -s; s c]; theta=[0:0.02:2*pi];
u=diag(C)*ones(2,length(theta)) + Q*[a*cos(theta); b*sin(theta)];
plot(C(1),C(2),'+');
hold on,plot(u(1,:),u(2,:));
u=u';