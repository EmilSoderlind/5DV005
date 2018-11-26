function fp=a2f2(y,h)

% MyDerivs  Computes approximations of derivatives
%
% CALL SEQUENCE: fp=a2f2(y)
%
% INPUT:
%   y     a one dimensional array of function values, y = f(x)
%   h     the spacing between the sample points x
%
% OUTPUT
%   fp    a one dimension array such that fp(i) approximates f'(x(i))
%
% ALGORITHM: Space central and asymmetric finite difference as needed
%
% MINIMAL WORKING EXAMPLE: MyDerivsMWE

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-26 Extracted from a working code

% Extract the number of points
m=numel(y);

% The exercise is pointless unless there are at least 3 points

% Allocate space for derivatives
fp=zeros(size(y));

% Do asymmetric approximation of the derivative at the left endpoint
fp(1) = 

% Do space central approximation of all derivatives at the internal points
% Do a for-loop *before* you attempt to do this as an array operation

% Do asymmetric approximation of the derivatives at the right endpoint
fp(m) = 