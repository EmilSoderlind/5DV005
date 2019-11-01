clear; clc; clf;

% MWE for range_rkx
% PROGRAMMING by
%   2018-12-11 Extracted and finished code by 
%               Betty Tornkvist (et16btt@cs.umu.se)
%               Emil Soderlind (id15@esd@cs.umu.se)
%               Jonas Sjodin (id16jsn@cs.umu.se)

% Load shells models
load shells.mat

% Specify shell and enviroment
param=struct('mass',10,'cali',0.088,'drag',@(x)mcg7(x),'atmo',@(x)atmosisa(x),'grav',@(x)9.82,'wind',@(t,x)[0, 0]);

% Set the muzzle velocity and the elevation of the gun
v0=780; theta=60*pi/180; 

% Select the method which will be used to integrate the trajectory
method='rk2'; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Compute the range of the shell
[r, flag, ~, tra]=range_rkx(param,v0,theta,method,dt,maxstep);

% Below follows a long sequence of commands which demonstrates how to get
% a very nice plot of the trajectory automatically

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
grid ON; axis([0 18000 -2000 10000]); grid MINOR;

% -----------------------------------
% Our new implementation
% -----------------------------------

%Define the number of points
m = 16000;
xpoints = 1:m;

% Create a hill and add it to the plot
hill = a2f6(xpoints);
hold on;
plot(xpoints, hill);

% Define function input
spacing = 1 / 100;
s = tra(1, :);
y = tra(2, :);
yp = MyDerivs(y, tra(1, 2) - tra(1, 1));
t = 14000:tra(1, end);

% Approximate the shell on t points
tra_app = MyPiecewiseHermite(s, y, yp, t);

% Calculate the difference in heigh of the approximated trajectory 
% and the hill
diff = tra_app - hill(14000:(14000 + length(tra_app) - 1));

% Find the point closest to the intersection point of the shell and 
% the hill. 
[~, ind] = min(abs(diff));

% Scatter plot the intersection point
hold on
scatter(14000 + ind, tra_app(ind),'filled', 'MarkerFaceColor',[0 0 0]);
