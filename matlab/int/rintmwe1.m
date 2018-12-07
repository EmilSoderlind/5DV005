% Interval
a=0; b=1; 

% Function
f=@(x)sqrt(x); 

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% Theoretical order of the method 
p=1.5; 

% Number of refinements
kmax=24; 

% True value of the integral 
val=2/3;

% Apply Richardson's techniques
[s, frac, est, err]=rint(f,a,b,rule,p,kmax,val);