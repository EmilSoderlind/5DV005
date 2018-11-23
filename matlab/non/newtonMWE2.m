% newtonMWE2  Minimal working example 2 for Newton's method

% Solve the non-linear equation 
%
%      x(1)^2*x(2)-3 =-2 
%      x(1) + x(2)   = 3 
%
% with respect to x=[x(1); x(2)].

% Define a function of two variables
f=@(x)[x(1)^2*x(2)-3; x(1)+x(2)];

% Define the Jacobian of f.
% This is 2 by 2 matrix consisting of all first order partial derivatives
df=@(x)[2*x(1)*x(2), x(1)^2; 1, 1];

% Define the right hand side of the equation
z=[-2;3];

% Define the initial guess
x0=[1.3; 0.8];

% Define the tolerance for the residual norm  
eps=1e-15; 

% Define the maximum number of iterations
maxit=10;

% Apply Newton's method to solving the equation f(x) = z
[x, flag, it, his, res, resnorm]=newton(f,z,df,x0,eps,maxit);
