function [s, frac, est, err, count]=rint(f,a,b,rule,p,kmax,val)

% RINT Richardson's technique for numerical integration
% 
% CALL SEQUENCE: [s, frac, est, err, count]=rint(f,a,b,rule,p,kmax,val)
%
% INPUT:
%   f       a user supplied function which calculates f(x)
%   a,b     endpoints specifying the interval in question
%   rule    the rule used to approximate the integral
%   p       the order of the method
%   kmax    an integer specifying the number of intervals to use
%   val     the exact integral (optional)
%
% OUTPUT:
%   s      different approximations of the integral
%   frac   Richardson's fractions
%   est    Richardson's error estimate     
%   err    the exact error, see below
%   count  measures the quality of the error estimate, see below
%
% ERR and COUNT are only computed if VAL is supplied. ERR(j)=VAL-S(j)
% and m=COUNT(j) is the largest integer such that
% 
%    |ERR(j) - EST(j)| \leq 0.5 * 10^(-m) |ERR(j)|
% 
% This is very nearly the number of correct digits in the error estimate.
%
% MINIMAL WORKING EXAMPLE: Integrate the function f(x)=exp(x) on [0,1]
% using the composite trapezoidal rule.
% 
% a=0; b=1; f=@(x)exp(x); 
% rule=@(y,a,b,N)trapezoid(y,a,b,N); p=2; kmax=24; val=exp(1)-1;
% [s, frac, est, err]=rint(f,a,b,rule,p,kmax,val);
%
% See also: RDIF, RODE, TRAPEZOID

% PROGRAMMING by Carl Christian K. Mikkelsen (spock@cs.umu.se) 
%  2012-12-XX  Initial programming and testing
%  2014-12-01  Streamlining and style adjusted to the new norm
%  2016-06-28  Integrated displaytable(). Improved documentation

% Allocate space for the output
s=zeros(kmax,1); frac=zeros(kmax,1); est=zeros(kmax,1); 

% Save time by only computing the function values ONCE. 
x=linspace(a,b,2^kmax+1); y=f(x);

if ~exist('val','var')
    % No solution was given
    flag=0;
    % The exact error can not be computed
    err=[]; count=[];
else
    % The integral was given
    flag=1;
end

% Set the number of intervals and the point separation
N=1; step=2^kmax;
for j=1:kmax
   s(j)=rule(y(1:step:end),a,b,N); N=N*2; step=step/2;
end

% Compute Richardson's fractions
for j=3:kmax
    frac(j)=(s(j-1)-s(j-2))/(s(j)-s(j-1));
end

% Compute Richardson's error estimates assuming that the order is ok
factor=2^p-1;
for j=2:kmax
    est(j)=(s(j)-s(j-1))/factor;
end

% Compute the actual error if exact target value is known
if (flag==1)
    % Allocate space for the error
    err=zeros(kmax,1); count=zeros(kmax,1);
    for j=1:kmax
        % Compute the actual error for the jth approximation
        err(j)=val-s(j); 
        % Compare the error estimate to the error.
        rel=(err(j)-est(j))/err(j);        
        % Find the largest integer m such that |rel| <= 0.5*10^(-m)
        count(j)=floor(-log10(2*abs(rel)));        
    end
end


%--------------------------------------------------------------------------
% Prepare the output for printing.
%--------------------------------------------------------------------------

% Indices for printing the table nicely
k=linspace(0,kmax-1,kmax)'; n=2.^k;

% Select basic data for printing.
data=[k s frac est];

% Define column headings
colheadings={'k','Ah','Richardson''s fraction','Error estimate'};

% Set column widths
wids=[6 18 18 18];

% Define column formats
fms={'d','.10e','.10e','.10e'};
    
if flag==1
    % The exact integral is known.
    % Append error and the comparison between error and estimate
    data=[data err count];
    
    % Append column headings
    colheadings=[colheadings {'Error','Comparison'}];
    
    % Append column widths
    wids=[wids 24 10];
    
    % Append formats
    fms=[fms {'.16e','d'}];
end

% Print the data nicely
displaytable(data,colheadings,wids,fms);

% Skip a line
fprintf('\n');