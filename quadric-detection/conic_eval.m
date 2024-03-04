function [d] = conic_eval(c, x)

d = c(1)*x(:, 1).^2 + c(2)*x(:, 2).^2 + c(3)*x(:, 1).*x(:, 2) + c(4).*x(:, 1) + c(5).*x(:, 2) + c(6);

end