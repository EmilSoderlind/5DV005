clear all;

% /////////////////////////////////////////////////////////////////////////
%  Initial setup of the gun and the method used to compute trajectories
% ////////////////////////////////////////////////////////////////////////

% Load shells models
load shells.mat

% Specify shell and physical enviroment
param=struct('mass',10,'cali',0.088,'drag',@(x)mcg7(x),'atmo',@(x)atmosisa(x),'grav',@(x)9.82,'wind',@(t,x)[-5; 0]);

% Define muzzle velocity
v0=780;

% Select the method which will be used to integrate the trajectory
method='rk2'; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Define the range function
range=@(theta)range_rkx(param,v0,theta,method,dt,maxstep);

% Define location of target
d=12345;

% Define the residual function res
res=@(theta)range(theta)-d;

% /////////////////////////////////////////////////////////////////////////
% Compute ballistics table using compute_range
% /////////////////////////////////////////////////////////////////////////

% Specify elevation in degress and convert to radian
deg=0:10:90; theta=deg*pi/180;

% Finally, compute and display the table of ranges using compute_range
[table, flag]=compute_range(param,v0,theta,method,dt,maxstep,1);

% /////////////////////////////////////////////////////////////////////////
% Find brackets for the low and the high trajectory
% /////////////////////////////////////////////////////////////////////////

% Find the indicies of all elevations corresponding to shots which go too far
idx=find(table(2,:)>d);

% Find a bracket for the low trajetory
alow=theta(min(idx) - 1);
blow=theta(min(idx));

% Find a bracket for the high trajectory
ahigh=theta(max(idx)); 
bhigh=theta(max(idx) + 1);

% /////////////////////////////////////////////////////////////////////////
% Set parameters for bisection
% /////////////////////////////////////////////////////////////////////////

% We don't quite know a good value of maxit
maxit=60; 

% We do not care about the error on the elevation
delta=0; 

% However, We destroy the target when the abs(res(theta))< 1 (meter)
eps=1;

% /////////////////////////////////////////////////////////////////////////
%  Compute the firing solutions using bisection
% /////////////////////////////////////////////////////////////////////////

%f=@(x)x.^2-2; x0=0; x1=2; maxit=60; delta=1e-15; eps=1e-15;
  
%[x, flag, it, a, b, his, res]=bisection(f,x0,x1,f(x0),f(x1),delta,eps,maxit,1);

% Low trajectoy
[a, lflag]=bisection(res,ahigh,bhigh,res(ahigh),res(bhigh),delta,eps,maxit,1);


% High trajectory
[b, hflag]=bisection(res,alow,blow,res(alow),res(blow),delta,eps,maxit,1);

% /////////////////////////////////////////////////////////////////////////
%  Recompute and plot trajectories
% /////////////////////////////////////////////////////////////////////////

% Low trajectory
[~, ~, ~, tra1]=range_rkx(param, v0, a, method, dt, maxstep);

% High trajectory
[~, ~, ~, tra2]=range_rkx(param, v0, b, method, dt, maxstep);

% Plot both trajectories in a single plot
plot(tra1(1,:),tra1(2,:), tra2(1,:),tra2(2,:));

% Add grid
grid; 

% Add suitable labels and legend
legend('high trajectory', 'low trajectory');
xlabel('x in meters');
ylabel('y in meters');
