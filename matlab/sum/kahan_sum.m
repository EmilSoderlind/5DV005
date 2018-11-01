function [y, flag]=kahan_sum(a,n,precision)

% KAHAN_SUM Sums terms using Kahan's method
%
% Uses Kahan's method to compute the sum of the terms in an array
%
% CALL SEQUENCE:
%
%     [y, flag]=kahan_sum(a,n,precision)
%
% INPUT:
%     a           an array with at least n elements
%     n           the number of terms to sum
%     precision   a string which sets the computing precision
%
% OUTPUT:  
%     y           if flag=1, then y is an approximation of the sum
%     flag        standard success/failure indicator
%                   if flag=0, then something went wrong
%                   ff flag=1, then an approximation was computed
%
% MINIMAL WORKING EXAMPLE
% Sum the first 2^10 terms of the harmonic series using single precision
%
% q=10; n=2^q; a=1./linspace(1,n,n); precision='single';
% [s, flag]=kahan_sum(a,n,precision);

% Programming: Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  2013-10-30: Initial version restricted to the harmonic series
%  2014-11-03: Code generalize to general series. Formatting enforced.
%  2015-11-05: Call sequence and minimal working example added
%
% General algorithm and error analysis by William Kahan (1965)

% Retrieve the number of elements in the array a.
m=numel(a);

% Set y to a dummy value and flag to failure
y=[]; flag=0;

% Test for elementary mistakes
if (n>m) 
    % There are not enough elements in a array
    display('Error: n is too large');
    % Return to caller immediately
    return;
end

% Create a copy of the input as a row vector
aux=reshape(a,1,m);

switch lower(precision)
    case 'single'
        % Force calculations to be done in single precision
        aux=single(aux); sum=single(0); c=single(0); t=single(0);
    case 'double'
        % Force calculations to be done in double precision 
        aux=double(aux); sum=double(0); c=double(0); t=double(0);
    otherwise
        display('Error: invalid precision specified, aborting!');
        return;
end

% At this point we are ready to do the actual sum
for i=1:n
    % Add the correction term to the ith term of the series
    y=aux(i)+c;
    % Add the corrected term y to the current sum
    t=sum+y;
    % Carefully compute how much we LOST in the last addition
    c=y-(t-sum);
    % Finally, update the value of the sum
    sum=t;
end
% At this point the sum has been computed
y=sum; flag=1;
