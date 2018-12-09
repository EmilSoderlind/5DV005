% A3F2  Minimal working example for A3F1

% Set trial function
f=@(x)exp(x); 

% Set point where we want to estimate the derivative
x=1; 

% Define the finite difference approximation
D1=@(g,x,h)(g(x+h)-g(x))./h; 

% Set the theoretical order of the method
p=1; 

% Set the basic stepsize
h0=0.125; 

% Set the number of times we will reduce the stepsize by a factor of 2
kmax=20; 

% Define the real derivative
df=@(x)exp(x);

% Allocate space for approximations
a=zeros(kmax,1);

% Construct the different approximations
h=h0;
for i=1:kmax
    % Compute approxmation
    a(i)=D1(f,x,h);
    % Reduce step size
    h=h/2;
end

% Compute target value
t=df(x);

% Apply Richardson's techniques
data=richardson(a,p,t);

% Display results
rdifprint(data,p);
    
