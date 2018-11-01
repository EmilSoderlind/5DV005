% US 155mm howitzer (WWII)

% Data extracted from
% https://en.wikipedia.org/wiki/M114_155_mm_howitzer

% Print header
fprintf('\nM114 155mm howitzer firing G7 shells (boat-tail) loaded\n\n');

% Ensure that the shell models are loaded
load shells

% Set the mass of the shell
param.mass=41.86;

% Caliber in meters
param.cali=0.15471;

% Select projectile type G7 (based on visual comparison by CCKM)
param.drag=@(x)mcg7(x);

% Select standard atmosphere
param.atmo=@(x)atmosisa(x);

% Select standard gravity
param.grav=@(x)9.80665;

% Select muzzle velocity
v0=563; 

% Do we want a demo?
if exist('pflag')
    if pflag==true
        
        % Display the parameters of the shell
        param
        
        % Select method and time step
        method='rk2'; dt=0.5; maxstep=2000;
        
        % Elevation: -2 to 63 degrees
        deg=[0:1:60 63]; theta=deg*pi/180;
        
        % Compute the firing table
        [table, flag]=compute_range(param,v0,theta,method,dt,maxstep,true);
    end
end
