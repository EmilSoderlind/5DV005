% German 420mm heavy siege gun aka "Dicke Bertha" (WWI)

% Data extracted from:
% https://en.wikipedia.org/wiki/Big_Bertha_%28howitzer%29

% Display header
fprintf('Dicke Bertha firing G1 shells loaded\n\n');

% Ensure that the shell models are loaded
load shells

% Set the mass of the shell
param.mass=820;

% Caliber in meters
param.cali=0.420;

% Select projectile type G1 (based on visual comparison by CCKM)
param.drag=@(x)mcg1(x);

% Select standard atmosphere
param.atmo=@(x)atmosisa(x);

% Select standard gravity
param.grav=@(x)9.80665;

% Select muzzle velocity
v0=400; 

% Do we want a demo?
if exist('pflag')
    if pflag==true
        
        % Display the parameters of the shell
        param
        
        % Select method and timestep
        method='rk2'; dt=0.5; maxstep=2000;
        
        % Elevation from 40 to 75 degrees
        deg=40:5:75; theta=deg*pi/180;
        
        % Compute the firing table
        [table, flag]=compute_range(param,v0,theta,method,dt,maxstep,true);
        
    end
end