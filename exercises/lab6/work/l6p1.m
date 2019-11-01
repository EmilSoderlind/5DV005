% RINTMWE1  Minimal working example for RINT

% Interval
a=0; b=3; 

% Function
%f=@(x)(exp(x).*sin(x)); 
%f=@(x)sqrt(1-x.^2)
f=@(x)(exp(-x.^2)/sqrt(pi))

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% Theoretical order of the method 
p=2; 

% Number of refinements
kmax=24; 

% True value of the integral 
val=exp(1)-1;

% Apply Richardson's techniques
data=rint(f,a,b,rule,p,kmax,val);

% Print the information nicely
rdifprint(data,p)
