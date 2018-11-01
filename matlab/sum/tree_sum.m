function [s, flag]=tree_sum(a,q,precision)

% TREE_SUM Sums terms using a binary tree
%
% Sums the first n=2^q terms of a given sequences using tree wise summation
%
% INPUT:
%    a           an array with at least 2^q terms
%    q           sum the first 2^q terms
%    precision   specificy the precision.
%
% OUTPUT:
%    y           an approximation of the sum if flag=1
%    flag        standard succes/failure flag, returns
%                   0  if something went wrong
%                   1  if a sum was computed
%
%
% MINIMAL WORKING EXAMPLE: 
% Sum the first 2^10 terms of the harmonic series using single precision
%
% q=10; a=1./linspace(1,2^q,2^q); precision='single';
% [s, flag]=tree_sum(a,q,precision);

% Programming:
%   Original in SUN Pascal by Professor Ole Oesterby, DAIMI, Aarhus
%   2010-08-XX Translated to MATLAB by CCKM (spock@cs.umu.se) 
%   2014-11-03 Formatting enforced
%   2015-11-05 Added minimal working example; fixed typographical errors 

% Nontrivial control structure :)
L=zeros(q+1,1);

% Retrieve the number of elements in the array
m=numel(a);

% Initialize the output
s=[]; flag=0;

% Check for elementary mistakes
if (m<2^q)
    display('q is too large, aborting!'); 
    return;
end

% Create a copy of the input as a row vector.
aux=reshape(a,1,m);

switch lower(precision)
    case 'single'
        % Force single precision arithmetic
        aux=single(aux);
        S=single(zeros(q+1,1)); sum=single(0);
    case 'double'
        % Force double precision calculations
        aux=double(aux);
        S=double(zeros(q+1,1)); sum=double(0);
    otherwise
        display('Invalid format requested, aborting');
        return;
end

% If we reach this point, then we are ready to compute the sum. 
% The loop is not trivial, but avoids to the need for recursion.
for i=1:2^q
  y=aux(i); sum=y+sum; k=1;
  while (L(k)==1)
    y=S(k)+y; S(k)=0; L(k)=0; k=k+1; 
  end
  S(k)=y; L(k)=1;
end
% At this point the sum has been computed and we can return.
s=S(q+1); flag=1;
