
% Define the interval
a=0; b=2;

% Select the function which defines the differential equation
f=@(t,y)(1/sqrt(2*pi))*exp(-(t^2)/(2)); 

% Specify the initial condition
y0=1/2;

% Select the number of timesteps
N1=10; N2=5; 

% Select the number of approximations
kmax=7;

% Specify the method to use and the *correct* order
method='rk2'; p=2; 

% The exact solution can be computed 
sol=@(t)0.5*(1+erf(t/sqrt(2)));

% Apply Richardson's techniques to our initial value problem
[s, frac, est, err]=rode(f,a,b,y0,N1,N2,kmax,method,p,sol);