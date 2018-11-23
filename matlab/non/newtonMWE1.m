% newtonMWE1  Minimal working example for Newton's method

% Solve the non-linear equation
% 
%    x^2 = 2
%
% with respect to x.

% Define the relevant function
f=@(x)x.^2;

% Define the right hand side
z=2;

% Define the derivative of f
df=@(x)2*x; 

% Define the initial guess
x0=1.4; 

% Define the tolerance for the residual
eps=1e-15; 

% Define the maximum number of iterations
maxit=10;

% Apply Newton's mehtod to the solution of the equation f(x)=2
[x, flag, it, his, res, resnorm] =newton(f,z,df,x0,eps,maxit);