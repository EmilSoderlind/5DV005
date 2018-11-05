function flag=scorched(seed,pflag)

% SCORCHED A engine for an artillery game similar to Scorched Earth
%
% The user is prompted for the x-coordinate of the gun and the target x=t.
% The target must be destroyed using at most 6 rounds. The gun's elevation
% must be specified using degrees, counter-clockwise starting at 3 o'clock.
% The program tracks the shell and computes the difference t-a, where x=a
% marks the point of impact of the shell. The target will be destroyed if
% the shell falls within 50 meters of the target.
% 
% CALL SEQUENCE: flag=scorched(seed,pflag)
%
% INPUT:
%   seed    a random seed used to generate the landscape
%   pflag   optional flag which affects the plotting of trajectories
%              pflag=0  (default) smooth curve 
%              pflag=1  smooth curve with data points (o)
%
% OUTPUT:  
%   flag    flag=1 if the target was destroyed in time   (victory)
%           flag=0 if the gun was destroyed by the enemy (defeat)
%
% Based on the DOS game "Scorched Earth" written by Wendell Hicken, 1991.

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  2016-08-05  Initial programming and testing
%  2016-08-09  Added color to the terrain
%  2016-08-10  Added title, labels. Added pflag to expose tunnelling.
%  2016-08-11  Some variables renamed for greater clarity
%  2016-09-09  Adapted to SHELL4A

% ALPHA-TESTING by
%    Birgitte Brydsö 
%    Matthias Åsander (suggested MRSI and variable power)
%    Pedher Johansson  
%    Mina Sedaghat (suggested the addition of grids)
%    Niclas Börlin
%    Lena Kallin Westin

% Current problems with event location: The shell can pass through hills.
%
% seed=17; g=6000; t=16000; theta=12.1.
% shell grazes the target after passing through two hills
%
% seed=17; g=2000; t=16000; theta=58.5 
% destroys target after shell passes through the hill next to the target.
%
% An improved event locator is required to resolve the problems away from 
% the gun. The barrel of the gun must have a nonzero length to avoid the 
% problem near the gun. Improved event location is possible, see EL for
% suggestions.
%
% Pretty or interesting landscapes: 
%  seed     description
%   15      central hill,  g=2000, t=15000, theta=62.4
%   114     two opposite hills
%   150     very large central hill
%   215     target hides behind a wall, g=3600, t=13800, theta=70.35

% Initialize the random generator
rng(seed);

% Obtain the coordinates of the corners of the screen
screen=get(groot,'Screensize'); 

% Isolate the width and height of the screen measured in pixels
sw=screen(3); sh=screen(4);
 
% Get a handle to the current figure
hFig=gcf; clf;

% Set the position of the desired window (upper left quarter of the screen)
set(hFig,'Position',[0 sh/4 sw/2 sh/2]);

% Experimental position of the screen for CCKM's desktop :)
set(hFig,'Position',[0 sh/8 sw/2 3*sh/4]);

% Generate fractal landscape
levels=6; N=2^levels+1; 

% CCKM's favorite landscapes
a=zeros(1,N); a(1)=2; a(N)=1; 

% Scale the landscape, kill negative values and lift everything 200 meters
b=land2(a)*2000; b(b<0)=0; b=b+200;

% Select nodes and construct spline to approximate landscape
nodes=linspace(0,18000,N); 

% Spline interpolant
cs=spline(nodes,b);

% Define the edge of the landscape as a function
h=@(x)ppval(cs,x); 

% Plot the landspace with one point pr. 50 meter
t=linspace(0,18000,3601); c=area(t,h(t)); c(1).FaceColor=[0 0.8 0.2];

% Add title and labels
title('Scorched Earth Engine 1.0'); xlabel('x (meters)'); ylabel('y (meters)');

% Set the range of the plot and turn on grids for readability
axis([0 18000 0 16000]); grid ON; grid MINOR; set(gca, 'layer', 'top');

% Hold the graphics window so that we can make multiple plots
hold;

% Obtain the x coordinate of the gun from the user
x1=input('Enter x-coordinate of gun    : '); y1=h(x1);

% Plot the location of the gun
plot(x1,y1,'o','MarkerFaceColor', 'b', 'MarkerSize', 10);

% Target coordinates
x2=input('Enter x-coordinate of target : '); y2=h(x2);

% Plot target coordinates
plot(x2,y2,'o','MarkerFaceColor', 'r', 'MarkerSize', 10);

% Load predefined shells
load shells

% Define the shell and the environment. 
% This is the "standard" gun for 5DV005
param=struct('mass',10,'cali',0.088,'drag',@(x)mcg6(x),'atmo',@(x)atmosisa(x),'grav',@(x)9.82);

% Slight wind blowing from left to right ...
param.wind=@(t,x)[5,0];

% Select muzzle velocity
v0=780; 

% Select integration method and number of time steps
method='rk2'; maxstep=300;

% Select maximum flight time
T=300;

% Select the kill radius of the shell
rho=50;

% Select the function which specifies the differential equation
f=@(t,x)shell4a(param,t,x);

% Define an event function; must be zero iff shell touches ground
g=@(x)x(2,:)-h(x(1,:));

% Set the maximum number of rounds allowed
maxit=6;

% The handle hTra will be used to plot the trajectories gradually.
% pflag determines if the computed points should be displayed or not
if exist('pflag','var')
    if pflag==true
        % Show computed data points with a marker ...
        hTra=animatedline('Marker','o');
    else
        % Just draw the trajectory
        hTra=animatedline;
    end
else
    % Just draw the trajectory
    hTra=animatedline;
end

for i=1:maxit
    % Obtain the elevation of the gun from the user
    theta=input('Enter elevation of gun in degrees: ');
    
    % Convert to radian
    theta=theta/180*pi;
    
    % Specify the initial condition, i.e. the position of the muzzle and the
    % velocity of the shell as it leaves the muzzle
    z0=[x1 y1 v0*cos(theta) v0*sin(theta)]';
    
    % Run the event locator seaching for 2 events
    [t, tra]=el(f,0,T,z0,maxstep,method,g,2);
    
    % Clear the old trajectory
    clearpoints(hTra); drawnow update
    
    % Plot the new trajectory gradually
    for k=1:numel(t)
        addpoints(hTra,tra(1,k),tra(2,k)); pause(0.025);
        drawnow update
    end
    
    % Calculate the distance between the point of impact and the target
    dist=norm([x2; y2]-tra(1:2,end));
    fprintf('Shell impacted at t-a=%5.0f. Distance to target was %5.0f.  ',x2-tra(1,end),dist);
    
    % Display comments on the quality of the shot :)
    if (dist>2000)
        fprintf('Indiscriminate shelling is a violation of the Geneva Convention!!!')
    end
    if (dist>1000 && dist<=2000)
        fprintf('Are you trying to get court-martialed?');
    end
    fprintf('\n');
    % Target is destroyed if the explosion is within rho meters.
    if (dist<=rho)
        fprintf('Target destroyed\n'); flag=1; break;
    end
    % Firing many times from the same location is dangerous as it allows
    % the enemy to detect the muzzle flash and locate your position ...
    if (i==maxit-1)
        fprintf('WARNING: Enemy shells are falling in our vicinity. Take cover!!!\n');
    end
    
end

% If 6 rounds have been expended without destroying target, then you lose!
if (dist>rho)
    fprintf('You have been destroyed by enemy counter-battery fire\n'); flag=0;
end

% Wait for the user to press a button
fprintf('Press any key to continue\n');
pause; close(hFig);