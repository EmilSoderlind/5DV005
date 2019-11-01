% A3F3  Physical parameters for firing a projectile

% Set parameters.
param.mass=10;
param.cali=0.088;

% Constant drag coefficient
param.drag=@(x)0.1873;

param.atmo=@(x)atmosisa(x);
param.grav=@(x)9.82;

% Select muzzle velocity and elevation
v0=780; theta=45*pi/180;

% From a3length VVVV

% Set initial time step
h0=1;

% Methods
m=["rk1","rk2","rk3","rk4"];

% Number of rows in table
kmax=13;

% Define the function needed for arc lenght
%g=@(z)sqrt(z(3,:).^2+z(4,:).^2);

% Loop over methods
for i=2:2
    % Select method
    method=m(i);

    % Initialize maxstep
    maxstep=200;
    
    % Loop over approximations
    for k=1:kmax
        
      %time step
      dt=2^-(k-1);
      
      % Compute range
      [r, flag, t, tra]=range_rkx(param,v0,theta,method,dt,maxstep);
      
      % VVVV -- Emil justerade 4:e 
      % Tar sista tids-värdet i tid-vektorn r
      a(k) = t(end);
      % ^^^ -- Emil justerade 4:e
      
      % Save information
      %a(k)=a3int(g,t,tra);
      %r + "h" -> Rich
      
      % Decrease time step
      %dt=dt/2;
      
      % Increase maxstep
      maxstep=maxstep*2;
    end
    
    % Run Richardsons techniques
    data=MyRichardson(a,i);
    
    % New figure
    h(i)=figure();
    
    % Print to screen
    rdifprint(data,i);
end