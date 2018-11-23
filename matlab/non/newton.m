function [x, flag, it, his, res, resnorm]=newton(f,z,df,x0,eps,maxit)

% NEWTON Newton's method for solving system of non-linear equations
%
% An implementation of Newton's method for solving a non-linear equation
%
%        f(x) = z
%
% with an initial guess x=x0. Traditionally, Newton's method is 
% applied to non-linear equations of the form
% 
%        g(x) = 0
%
% and the code defines g(x) = f(x) - z in honor of this tradition.
%
% CALL SEQUENCE:
%
% [x, y, flag, it, his, res, resnorm]=newton(f,z,df,x0,eps,maxit)
%
% INPUT:
%   f         a handler to the function f
%   z         the right hand side of the equation
%   df        a handler to the derivative (Jacobian) of f
%   x0        the initial guess
%   eps       break when the current residual has norm less than eps
%   maxit     maximum number of iterations allowed
%
% OUTPUT:
%   x         the final approximation
%   flag      a flag signaling succes/failure, if flag = 
%                -1,  then we did not converge in maxit iterations
%                 0,  then the final residual norm is less than eps
%   it        the number of iterations completed
%   his       his(j) is the jth approximation
%   res       res(j) is the jth residual
%   resnorm   resnorm(j) is the norm of the jth residual
%
% See also: BISECTION, SECANT, RSECANT

% PROGRAMMING by Carl Christian K. Mikkelsen (spock@cs.umu.se)
%  2014-10-20  Call sequence determined
%  2014-10-21  Initial implementation and testing
%  2014-11-20  More comments added in response to student questions
%  2015-10-16  Documentation edited
%  2016-06-27  Documentation edited. Added links to other methods
%  2016-06-27  Change code to conform to standard
%  2016-08-15  Minor changes to the documentation
%  2018-11-23  Move the minimal working examples to separate files
%  2018-11-23  Changed return codes

%--------------------------------------------------------------------------
% We skip a sanity check and assume the everything is compatible!
%--------------------------------------------------------------------------

% Newton's method is tricky to apply, so flag=-1 is the default
flag=-1;

% Extract the dimension of the problem
n=numel(x0);

% Allocate space for approximations, residuals, and their norms
his=zeros(n,maxit); res=zeros(n,maxit); resnorm=zeros(1,maxit);

% Initialize the sequence with a column vector
x=reshape(x0,n,1);

% Define the function g(x) = f(x)-z;
g=@(x)f(x)-z;

% Define the Jacobian of g with to the variable x
dg=@(x)df(x);

for j=1:maxit
    % Save the current approximation into his
    his(:,j)=x;
    % Save the current residual
    y=g(x); res(:,j)=y;
    % Save the norm of the current residual
    resnorm(j)=norm(y);
    % Is the residual small enough?
    if (resnorm(j)<=eps)
        % We have converged to the specified tolerance
        flag=0; break;
    else
        % Do one step of Newton's method. This expression works for all n!
        x=x-dg(x)\y;
        % If you were expecting to see the expression x=x-y/dg(x), then be
        % advised that it would only work for n=1. The backslash operator
        % solves the correct linear system
    end
end

% Remove any trailing zeros from output arrays
his=his(:,1:j); res=res(:,1:j); resnorm=resnorm(1:j);

% Set the number of iterations completed
it=j;