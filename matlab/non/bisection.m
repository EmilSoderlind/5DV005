function [x, flag, it, a, b, his, res]=bisection(f,x0,x1,f0,f1,delta,eps,maxit,print)

% BISECTION Bisection algorithm for solving non-linear scalar equations
%
% Attempts to solve the non-linear equation scalar equation
%
%   f(x) = 0
%
% using the bisection algorithm.
%
% CALL SEQUENCE:
%
%   [x, flag, it, a, b, his, res]=bisection(f,x0,x1,f0,f1,delta,eps,maxit,print)
%
% INPUT:
%   f        a handler to the function f
%   x0, x1   specifies the initial bracket/search interval
%   f0, f1   function values at x0 and x1
%   delta    break if the current bracket has size less than delta
%   eps      break if the current residual has size less than eps
%   maxit    maximum number of iterations allowed
%   print    an optional argument, default value is false
%              if print=true, then the results are printed
%
% OUTPUT:
%   x        the final approximation of the root
%   flag     a flag signaling succes/failure, if flag = 
%              -1,  then the initial bracket was bad
%               0,  then the iteration did not converge
%               1,  then the last bracket has length less than delta
%               2,  then the last residual has size less than eps
%               3,  then the two previous conditions are both true
%   it       the number of iterations completed
%   a, b     a(j) and b(j) form the jth bracket around the root
%   his      a vector containing all approximations (his = history)
%   res      the corresponding residuals (res=residual)
% 
% A bad bracket is a pair of points a, b, such that f(a)*f(b) >= 0. In this
% case, we can not conclude that there is a root strictly between a and b. 
%
% MINIMAL WORKING EXAMPLE: Solve the equation f(x)=0, where f(x)=x^2-2.
%
% f=@(x)x.^2-2; x0=0; x1=2; maxit=60; delta=1e-15; eps=1e-15;
% [x, flag, it, a, b, his, res]=bisection(f,x0,x1,f(x0),f(x1),delta,eps,maxit,1);
%
% returns x = 1.414213562373095 which is *very* close to sqrt(2).
%
% See also: NEWTON, SECANT, RSECANT

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  2014-05-12  Initial programming and testing
%  2014-10-20  Call sequence and comments improved
%  2014-11-12  All arguments are now assigned values regardless of flag
%  2014-11-16  Program rewritten from scratch to clarify the logic
%  2015-09-22  Minor improvements to the documentation and comments
%  2016-06-14  Minor improvements to the documentation and comments
%  2016-06-21  Program rewritten from scratch to conform with secant family
%  2016-06-27  Integrated displaytable(). Added links to other methods.
%  2016-08-15  Minor changes to the documentation
%  2016-11-14  Fixed incomplete initialisation
%  2016-11-16  Fixed error in call sequence.
%  2016-11-25  Fixed error in call sequence documentation.
%  2017-10-25  Rename pflag to print

% DEBUGGING:
%  2016-11-11  Incomplete initialization located by Hanna Konradsson
%  2016-11-15  Error in call sequence found by Mikael Johannsson

% TODO:
%   CCKM  Go over the "rare" cases again and update the documentation
%   CCKM  Allow for solution of g(f(x)) = 0, returning BOTH x and f(x)

% Solving nonlinear equations is hard, so assume non-convergence.
flag=0;

%--------------------------------------------------------------------------
% Sanity check of the input
%--------------------------------------------------------------------------

% In MATLAB
%    sign(x) = +1, if x is strictly positive
%    sign(x) =  0, if x is zero
%    sign(x) = -1, if x is strictly negative, 

% Protect against "rare" events!
if sign(f0)==0
    flag=2; x=x0; 
end

if sign(f1)==0
    flag=2; x=x1; 
end

if (flag==2)
    % Initialize all remaining output
    it=0; a=min(x0,x1); b=max(x0,x1); his=NaN; res=NaN; return;
end

% At this point we know that f0 and f1 have nonzero sign. Why?
if (sign(f0)*sign(f1)>0)
    % The initial bracket is bad, nothing can be said
    flag=-1; x=NaN;
    % Initialize all remaining output
    it=0; a=min(x0,x1); b=max(x0,x1); his=NaN; res=NaN; return;
end

%--------------------------------------------------------------------------
% At this point we know that there is a root *between* x0 and x1. Why?
%--------------------------------------------------------------------------

% Allocate space for all variables
a=zeros(1,maxit); b=zeros(1,maxit); his=zeros(1,maxit); res=zeros(1,maxit);

% Intialize the bracket so that alpha < beta
if x1<x0
    alpha=x1; fa=f1; beta=x0; fb=f0;
else
    alpha=x0; fa=f0; beta=x1; fb=f1;
end

% Initialize the flag assuming failure
flag=0;

% Main loop
for j=1:maxit
    % Record the current bracket/search interval
    a(j)=alpha; b(j)=beta;
    
    % Carefully compute the midpoint
    c=alpha+(beta-alpha)/2;
    
    % Evaluate f at the midpoint
    fc=f(c);
    
    % Save the current values
    x=c; his(j)=c; res(j)=fc;
    
    % Check for small bracket
    if abs(alpha-beta)<=delta
        flag=1;
    end
    
    % Check for small residual
    if abs(fc)<=eps
        flag=flag+2;
    end
    
    % Are we happy?
    if flag>0
        % Yes, we are happy, but a human should check the results
        break;
    end
    
    %----------------------------------------------------------------------
    % At this point we know that we need more iterations.
    %----------------------------------------------------------------------
    
    % Rebracket the root
    if sign(fa)*sign(fc)==-1
        beta=c; fb=fc;
    else
        alpha=c; fa=fc;
    end
end

% Remove any trailing zeros from output arrays
a=a(1:j); b=b(1:j); his=his(1:j); res=res(1:j);

% Set the number of iterations completed
it=j;

% Check if the user wants the output printed nicely or not?
if exist('print','var')
    if print==true
        %--------------------------------------------------------------------------
        % Prepare the output for printing.
        %--------------------------------------------------------------------------

        % Define iterations numbers
        n=linspace(1,it,it);

        % Select the data for printing
        data=[n' a' b' his' res'];

        % Define the column headingsh
        colheadings = {'iter', 'a','b','approximation','residual'};

        % Set the widths of the columns
        wids=[6 22 22 22 22];

        % Define the format specification
        fms={'d','.15e','.15e','.15e','.15e'};

        % Print the data nicely
        displaytable(data,colheadings,wids,fms);
    end
end