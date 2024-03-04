function [Q] = alg_to_conic(x)

% F = A.*X.^2 + B.*Y.^2 + 2.*D.*X.*Y + 2.*G.*X + 2.*H.*Y + J;

numConics = size(x,1);
if (size(x,2)==6 && numConics>1)
    Q = zeros(4,4,numConics);
    for i=1:numConics
        Q(:,:,i) = alg_to_conic(x(i,:));
    end
else
    Q = zeros(3,3);
    
    Q(1,2) = x(3)./2;
    Q(1,3) = x(4)./2;
    Q(2,3) = x(5)./2;
    
    % symmetrize:
    Q = Q + Q';
    Q(1,1) = x(1);
    Q(2,2) = x(2);
    Q(3,3) = x(6);
end
end