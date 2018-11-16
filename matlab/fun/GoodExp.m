function y=GoodExp(x)

% GoodExp  Improved version of BadExp
%
% Extends the good behavior of BadExp for nonnegative x to all x using the
% identity 
%           exp(x) = 1/exp(-x)
% 
% CALL SEQUENCE:  y=GoodExp(x);
%
% INPUT:
%   x      an array of input values
%
% OUTPUT:
%   y      approximations of exp(x)

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2017-XX-YY Initial programming and testing
%   2017-11-25 Brought the code up to the expected standard

% Find the indices for the nonnegative x values
idx1=find(x>=0);

% Find the indices for the negative x values
idx2=find(x<0);

% Initialize space for output
y=zeros(size(x));

% Apply BadExp to directly to the nonnegative function values
y(idx1)=BadExp(x(idx1));

% Exploit the identity 1/exp(-x) = exp(x) to handle the negative values
y(idx2)=1./BadExp(-x(idx2));