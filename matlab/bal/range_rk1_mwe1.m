% MWE for range_rk1

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-01  Adapted from existing script and including a plot

% Load shell models
load shells

% Specify shell, drag function, atmosphere, gravity, and no wind
param=struct('mass',10,'cali',0.088,'drag',@(x)mcg7(x),'atmo',@(x)atmosisa(x),'grav',@(x)9.82,'wind',@(t,x)[0; 0]);

% Set the muzzle velocity and the elevation of the gun
v0=780; theta=45*pi/180; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Compute the range of the shell
[r, flag, t, tra]=range_rk1(param,v0,theta,dt,maxstep);

% Plot the trajectory nicely
plot(tra(1,:),tra(2,:)); 

% Adjust axis to use the same scale
axis equal;

% Add a coarse and a fine grid
grid on; grid minor;