% D-20 152mm howitzer (USSR, early 1950s)

% Data extracted from:
% https://en.wikipedia.org/wiki/152_mm_towed_gun-howitzer_M1955_%28D-20%29

% Load shell models
load shells

% Set the mass of the shell
param.mass=44;

% Caliber in meters
param.cali=0.1524;

% Select projectile type G7 (based on visual comparison by CCKM)
param.drag=@(x)mcg7(x);

% Select standard atmosphere
param.atmo=@(x)atmosisa(x);

% Select standard gravity
param.grav=@(x)9.80665;

% Select muzzle velocity
v0=655; 

% Set the mass of the shell
param.mass=44;

% Select standard gravity
param.grav=@(x)9.8065;

% Select muzzle velocity
v0=655;

% Select method and time step for integration
method='rk2'; dt=1; 

% Select maximum number of timesteps
maxstep=1000;

% Define range function
r=@(theta)range_rkx(param,v0,theta,method,dt,maxstep);

% Print header
fprintf('D20 152mm howitzer firing G7 shells (boat-tail) loaded\n\n');