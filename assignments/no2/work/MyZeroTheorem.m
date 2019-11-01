% Define a nice function
f=@(x)exp(x).*sin(x);

% Define the derivative fp (fprime) of f
fp=@(x)exp(x).*(sin(x)+cos(x));

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
x0=0;
x1=pi;

% The function values corresponding to the initial search bracket
fp0=fp(x0);
fp1=fp(x1);

% Tolerances and maxit for bisection.
tol=10^-13; maxit = 1000;

% Run the bisection algorithm to find the zero c of fp
c=bisection(fp, x0, x1, fp0, fp1, 10^-10, 10^-10, maxit, 1);

% Define the tangent at this point; this a constant function.
w=@(x)ones(size(x))*f(c);

% Plot the tangent
hold on
plot(s, w(s));

    
% /////////////////////////////////////////////////////////////////////////
%  Illustration of the mean value theorem
% /////////////////////////////////////////////////////////////////////////

% Define points for corde
x0=2; x1=pi;
% Define a nice function
f=@(x)exp(x).*sin(x);

% Define the derivative fp (fprime) of f
fp=@(x)exp(x).*(sin(x)+cos(x));

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
x0=0;
x1=pi;

% The function values corresponding to the initial search bracket
fp0=fp(x0);
fp1=fp(x1);

% Tolerances and maxit for bisection.
tol=10^-13; maxit = 1000;

% Run the bisection algorithm to find the zero c of fp
c=bisection(fp, x0, x1, fp0, fp1, 10^-10, 10^-10, maxit, 1);

% Define the tangent at this point; this a constant function.
w=@(x)ones(size(x))*f(c);

% Plot the tangent
hold on
plot(s, w(s));

    
% /////////////////////////////////////////////////////////////////////////
%  Illustration of the mean value theorem
% /////////////////////////////////////////////////////////////////////////

% Define points for corde
x0=2; x1=pi;

% Compute corresponding function values
f0 = f(x0);
f1 = f(x1);

% Define the linear function which connects (x0,f0) with (x1,f1)
k = (f1-f0)/(x1 -x0);
m = f1 -k * x1;

p=@(x)(k*x + m); % lutning is here

% Plot the straight line between (x0,f0) with (x1,f1)
hold on
plot(s,p(s));

% Compute the slope of the corde
yp=k;

% Define an auxiliary function which is zero when fp equals yp
g=@(x)(fp(x) - yp);

% Run the bisection algorithm to find a zero c of g
c = bisection(g, x0, x1, g(x0), g(x1), tol, tol, maxit, 1);

% Define the line which is tangent to the graph of f at the point (c,f(c))
m = f(c) - yp*c;
q=@(x)(m +  k * x);

% Plot the tangent line
plot(s,q(s));

% Labels
xlabel('x'); ylabel('y');

% Print the figure to a file
print('MyZeroTheorems','-depsc2');
% Compute corresponding function values
f0 = f(x0);
f1 = f(x1);

% Define the linear function which connects (x0,f0) with (x1,f1)
k = (f1-f0)/(x1 -x0);
m = f1 -k * x1;

p=@(x)(k*x + m); % lutning is here

% Plot the straight line between (x0,f0) with (x1,f1)
hold on
plot(s,p(s));

% Compute the slope of the corde
yp=k;

% Define an auxiliary function which is zero when fp equals yp
g=@(x)(fp(x) - yp);

% Run the bisection algorithm to find a zero c of g
c = bisection(g, x0, x1, g(x0), g(x1), tol, tol, maxit, 1);

% Define the line which is tangent to the graph of f at the point (c,f(c))
m = f(c) - yp*c;
q=@(x)(m +  k * x);

% Plot the tangent line
plot(s,q(s));

% Labels
xlabel('x'); ylabel('y');

% Print the figure to a file
print('MyZeroTheorems','-depsc2');