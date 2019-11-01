function z=testphi(f,t,y,dt)

% Special edition psiii

% PHI4 Kernel for the classical explicit fourth order Runge Kutta method
%
% Advances the solution of the ODE
%
%     y'(t) = f(t,y(t))
%
% a single time step using the classical Runge-Kutta method of order 4.
%
% See also: RK, PHI1, PHI2, PHI3

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se) 
%  Apr 2014   :  Initial coding and testing.
%  Oct 2014   :  Minor changes to the text.
%  2015-06-23 :  Reformated during yearly review.

% Compute auxiliary coefficients
k1=f(t,y);  
k2=f(t+0.5*dt,y+0.5*dt*k1);
k3=f(t+dt,y-dt*k1+2.*dt*k2);

% Advance the solution a single step
z=y+(dt/6)*(k1+4*k2+k3);

