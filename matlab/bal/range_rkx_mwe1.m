% MWE for range_rkx

% Load shells models
load shells.mat

% Specify shell and enviroment
param=struct('mass',10,'cali',0.088,'drag',@(x)mcg7(x),'atmo',@(x)atmosisa(x),'grav',@(x)9.82,'wind',@(t,x)[-5; 0]);

% Set the muzzle velocity and the elevation of the gun
v0=780; theta=45*pi/180; 

% Select the method which will be used to integrate the trajectory
method='rk2'; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Compute the range of the shell
[r, flag, t, tra]=range_rkx(param,v0,theta,method,dt,maxstep);

% Below follows a long sequence of commands which demonstrates how to get
% a very nice plot of th[e trajectory automatically

% Obtain the coordinates of the corners of the screen
screen=get(groot,'Screensize'); 

% Isolate the width and height of the screen measured in pixels
sw=screen(3); sh=screen(4);

% Obtain a handle to a new figure
hFig=gcf;

% Set the position of the desired window
set(hFig,'Position',[0 sh/4 sw/2 sh/2]);

% Plot the trajectory of the shell.
plot(tra(1,:),tra(2,:)); 

% Turn of the major grid lines and set the axis
grid ON; axis([0 18000 0 12000]); grid MINOR;

