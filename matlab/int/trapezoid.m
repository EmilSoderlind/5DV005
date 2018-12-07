function s=trapezoid(y,a,b,N)

% TRAPEZOID Composite trapezoidal rule for a function on an interval
%
% CALL SEQUENCE: s=trapezoid(y,a,b,N)
%
% INPUT:
%   y      the function values on N+1 equidistant points on [a,b]
%   a, b   the interval 
%   N      determines the stepsize, h=(b-a)/N
% 
% OUTPUT:
%  s      the trapezoidal sum. 
%
% MINIMAL WORKING EXAMPLE: Compute trapezoidal sum for f(x)=exp(x) on
% the interval [0,1] using N=8 subintervals.
%
% a=0; b=1; N=8; x=linspace(a,b,N+1); f=@(x)exp(x); y=f(x);
% s=trapezoid(y,a,b,N)
%
% See also: RINT

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  2015-XX-YY  Initial programming and testing
%  2016-06-28  Reformatted during yearly review

% Compute the length of the subintervals
h=(b-a)/N;

% Compute the trapezoidal sum.
s=0; 
for i=1:N
    s=s+(y(i)+y(i+1))*h/2;
end

