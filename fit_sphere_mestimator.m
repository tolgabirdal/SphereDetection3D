function [c, r] = fit_sphere_mestimator(X, c, r,iterations, maxUpdate, shouldPlot, fullCloud)

if(~exist('fullCloud','var'))
    fullCloud = [];
end
N = length(X);
sol0 = [c; r];

[Xs, Ys, Zs] = sphere;

opts = statset('nlinfit');
opts.Robust = 'on';
opts.RobustWgtFun = 'bisquare';
opts.Display = 'iter';
%opts = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt');
lb = [];
ub = [];

sol0 = [c; r];

initY = spherefitfun(sol0, X);
validInd = (initY<0.1);
X = X(validInd,:);

if (shouldPlot)
    if (~isempty(fullCloud))
        pcshow(X,'MarkerSize',64);
        hold on, draw_sphere(c, r);
        hold off;
    end
    pause(0.1);
end

Y = zeros(length(X), 1);
sol = nlinfit(X,Y,@spherefitfun,sol0,opts);
%sol = robustlsqcurvefit(@spherefitfun,sol0,X,Y,'bisquare',opts);

c = sol(1:3);
r = sol(4);

end

function y = spherefitfun(x, Xdata)

c = x(1:3);
r = x(4);
D = repmat(c', length(Xdata), 1) - Xdata;
err = sqrt(dot(D, D, 2));
y = abs(err-r);

end

% i = 0;
% update = 999999;
% while(i<iterations && update>maxUpdate)
%     
%     
%     
%     
%     
%     c = sol(1:3);
%     r = sol(4);
%     update = norm(sol-sol0);
%     sol0 = sol;
%     if (shouldPlot)
%         if (~isempty(fullCloud))
%             pcshow(fullCloud);
%             hold on, draw_sphere(sol(1:3), sol(4));
%             hold off;
%         else
%             plot_iterate(X, Xs, Ys, Zs, sol(4), sol(1:3));
%         end
%         pause(0.1);
%     end
%     i = i+1;
% end
% 
% c = sol(1:3);
% r = sol(4);
% 
% end
% 
% function plot_iterate(x, X, Y, Z, r0, c0)
% plot3(x(:,1), x(:,2), x(:,3), 'b+');
% hold on,plot3(X*r0+c0(1), Y*r0+c0(2), Z*r0+c0(3), 'k');
% axis equal;
% hold off;
% end
