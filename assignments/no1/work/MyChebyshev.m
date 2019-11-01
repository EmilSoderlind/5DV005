function y=MyChebyshev(n,x)

% A1F1 Evaluates the first n Chebyshev polynomials
%
% CALL SEQUENCE: y=A1F1(n,x)
%
% INPUT:
%   n    the number of polynomials
%   x     a vector of length m containing the sample points
%
% OUTPUT:
%   y     a matrix of dimension m by n such that y(i,j) = T(j,x(i))
%
% MINIMAL WORKING EXAMPLE: Missing

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.ume.se)
%  2018-11-14 Skeleton extracted from working function


% Determine number of element in x
m = length(x);

% Reshape x as a column vector 
x = reshape(x, m, 1);

% Allocate space for output y
y = zeros(m, n);

% Initialize the first two columns of y
y(:, 1:2) = [ones(m, 1) x];

% Calculate all remaining columns of y
for i=3:n 
    y(:, i) = 2.*x.*y(:, i-1) - y(:, i-2);
end



