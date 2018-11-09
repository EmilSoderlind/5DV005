% COMPUTE_RANGE_MWE1 MWE for compute_range

% Fire a shell with 
%     constant drag coefficient, 
%     homogene atmosphere, 
%     constant gravity, 
%     and no wind. 

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2017-10-24 Extracted from compute_range

% load d-20
d20;

% Set shell parameters equal to a crude approximation of Flak 36 gun
param=struct('mass',10,'cali',0.088,'drag',@(x)0.1879,'atmo',@(x)atmosisa(x),'grav',@(x)9.82);


% Select integration method, time step size and maximum number of steps
method='rk2'; dt=0.1; maxstep=2000;

% Specify elevation in degress and convert to radian
deg=[0:5:90]; theta=deg*pi/180;
 
% Finally, produce the table of ranges
[table, flag]=compute_range(param,v0,theta,method,dt,maxstep,true);

dt=0.2;
% Finally, produce the table of ranges
[table, flag]=compute_range(param,v0,theta,method,dt,maxstep,true);
