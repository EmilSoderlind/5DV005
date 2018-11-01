% PLOT_SHELLS  Plots the drag coefficient function for standard shells

% Load the shell functions
load shells;

% Define a range of Mach numbers
ma=linspace(0,5,1001);

% Obtain the coordinates of the corners of the screen
screen=get(groot,'Screensize'); 

% Isolate the width and height of the screen measured in pixels
sw=screen(3); sh=screen(4);
 
% Get a handle to the current figure
hFig=gcf; clf;

% Configure the position of the shell (central portion of the screen)
set(hFig,'Position',[sw/4 sh/4 sw/2 sh/2]);

% Plot the drag coefficients functions for the standard shells
subplot(2,3,1); plot(ma,mcg1(ma)); title('g1 drag coefficient'); axis([0,5,0,0.7]); xlabel('Mach number');
subplot(2,3,2); plot(ma,mcg2(ma)); title('g2 drag coefficient'); axis([0,5,0,0.7]); xlabel('Mach number'); 
subplot(2,3,3); plot(ma,mcg5(ma)); title('g5 drag coefficient'); axis([0,5,0,0.7]); xlabel('Mach number'); 
subplot(2,3,4); plot(ma,mcg6(ma)); title('g6 drag coefficient'); axis([0,5,0,0.7]); xlabel('Mach number'); 
subplot(2,3,5); plot(ma,mcg7(ma)); title('g7 drag coefficient'); axis([0,5,0,0.7]); xlabel('Mach number'); 
subplot(2,3,6); plot(ma,mcg8(ma)); title('g8 drag coefficient'); axis([0,5,0,0.7]); xlabel('Mach number'); 

