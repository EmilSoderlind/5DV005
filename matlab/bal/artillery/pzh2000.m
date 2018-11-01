% German 155mm self-propelled howitzer (current era)

% Data extracted from:
% http://www.navweaps.com/Weapons/WNGER_61-52_MONARC.htm

% Print header
fprintf('\nPanzerhaubitze 2000 firing G7 shells (boat-tail) loaded\n');

% Ensure that the shell models are loaded
load shells

% Set the mass of the shell
param.mass=44.5;

% Caliber in meters
param.cali=0.155;

% Select projectile type G7 (based on visual comparison by CCKM)
param.drag=@(x)mcg7(x);

% Select standard atmosphere
param.atmo=@(x)atmosisa(x);

% Select standard gravity
param.grav=@(x)9.80665;

% Select muzzle velocity
v0=945; 

% Do we want a demo?
if exist('pflag')
    if pflag==true
        
        % Display the parameters of the shell
        param
        
        % Select method and time step
        method='rk2'; dt=0.5; maxstep=2000;
        
        % Elevation range has not been made public yet
        deg=0:5:90; theta=deg*pi/180;
        
        % Compute the firing table
        [table, flag]=compute_range(param,v0,theta,method,dt,maxstep,true);
    end
end