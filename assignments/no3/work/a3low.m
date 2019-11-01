clear all;

% /////////////////////////////////////////////////////////////////////////
%  Initial setup of the gun and the method used to compute trajectories
% ////////////////////////////////////////////////////////////////////////

% Load shells models
load shells.mat

% Set parameters.
param.mass=10;
param.cali=0.088;

% Constant drag coefficient
param.drag=@(x)0.1873;
param.atmo=@(x)atmosisa(x);
param.grav=@(x)9.82;

% Define muzzle velocity
v0=780;

% Select the method which will be used to integrate the trajectory
method='rk1'; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Define location of target
d=15000;

alow=0;
blow=(pi/4);
delta=10^-15;
eps=10^-15;
maxit=200;

n = 10;
result = zeros(1, n);

for i=1:n
    % Define the range function
    range=@(theta)range_rkx(param,v0,theta,method,dt,maxstep);
    % Define the residual function res
    res=@(theta)range(theta)-d;
    
    [x, flag, it, a, b, his, res]=bisection(res,alow,blow,res(alow),res(blow),delta,eps,maxit,0);
    
    result(i) = x;
    dt = dt / 2;
    maxstep = maxstep * 2;
end

degree=1;
% Run Richardsons techniques
data=MyRichardson(result,degree);

% New figure
h(degree)=figure();
    
% Print to screen
rdifprint(data,degree);

