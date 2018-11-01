function b=land2(a)
% LAND2  2D fractal landscape
%
% CALL SEQUENCE: b=land2(a)
%
% INPUT:
%   a     array of length n=2^k+1, where k is a nonnegative integer
% 
% OUTPUT:
%   b     a heightmap of length n

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%
% Adapted from the 3D terrain generator LAND given in
% Desmond J. Higham and Nicholas J. Higham: "MATLAB Guide"
% http://www.siam.org/books/ot92/

n=length(a);
d=(n+1)/2;
level=log2(n-1);
scalef = 0.06*(2^(0.9*level));

b=a;
b(d)=mean([a(1) a(n)])+scalef*randn;
if n>3
    b(1:d)=land2(b(1:d));
    b(d:n)=land2(b(d:n));
end


