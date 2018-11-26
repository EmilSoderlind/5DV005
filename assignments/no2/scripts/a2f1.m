% Define a nice function
f=@(x)exp(x).*sin(x);

% Define the derivative fp (fprime) of f
fp=@(x)

% Interval
a=0; b=pi;

% Number of subintervals
n=100;

% Sample points for plotting
s=linspace(a,b,n+1);

% Plot the graph
h=figure; plot(s,f(s));

% Hold the graph
hold on;

% Turn on grid
grid on;

% Axis tight
axis tight

% /////////////////////////////////////////////////////////////////////////
%  Illustration of Runge's theorem
% /////////////////////////////////////////////////////////////////////////

% Initial search bracket
x0=
x1=  

% The function values corresponding to the initial search bracket
fp0=
fp1=

% Tolerances and maxit for bisection.

% Run the bisection algorithm to find the zero c of fp
c=

% Define the tangent at this point; this a constant function.
w=@(x)ones(size(x))*f(c);

% Plot the tangent

    
% /////////////////////////////////////////////////////////////////////////
%  Illustration of the mean value theorem
% /////////////////////////////////////////////////////////////////////////

% Define points for corde
x0=2; x1=pi;

% Compute corresponding function values
f0
f1

% Define the linear function which connects (x0,f0) with (x1,f1)
p=

% Plot the straight line between (x0,f0) with (x1,f1)
plot(s,p(s))

% Compute the slope of the corde
yp=

% Define an auxiliary function which is zero when fp equals yp
g

% Run the bisection algorithm to find a zero c of g
c

% Define the line which is tangent to the graph of f at the point (c,f(c))
q=

% Plot the tangent line
plot(s,q(s));

% Labels
xlabel('x'); ylabel('y');

% Print the figure to a file
print('MyZeroTheorems','-depsc2');