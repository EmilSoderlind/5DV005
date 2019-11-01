function z=MyPiecewiseHermite(s,y,yp,t)

% A2F4 Evaluate Hermite's piecewise approximation

% INPUT:
%   s    a linear array of m points where f and f' are known
%   f    the function values, y = f(s)
%   fp   the derivatives, yp = f'(s)
%   t    a linear array of sample points where z=p(t) is sought
%
% OUTPUT:
%   z    the values of Hermite's piecewise approximation, z = p(t)
% 
%
% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-25 Initial programming and testing
%   2018-12-11 Extracted and finished code by 
%               Betty Tornkvist (et16btt@cs.umu.se)
%               Emil Soderlind (id15@esd@cs.umu.se)
%               Jonas Sjodin (id16jsn@cs.umu.se)

% Determine the number of points
m=numel(t);

% Define the polynomial p0 
p0=@(x)((1+2.*x).*((1-x).^2));
% Define the polynomial p1
p1=@(t)(t.^2*(3-2.*t));
% Define the polynomial q0
q0=@(t)(t.*(1-t).^2);
% Define the polynomial q1
q1=@(t)(t.^2.*(t-1));

% Determine the number of sample points where we know f and f'
n=numel(s);
z = zeros(1, m);

% Loop over all points of t
for i=1:m
    % Isolate the ith value of t into a variable tau
    tau=t(i);
    % Find the interval s(j), s(j+1) which contains tau
    j=find(s(1:n-1)<=tau,1,'last');
    % Isolate the endpoints of the interval which contains tau into a, b
    a=s(j); b=s(j+1);
    % Map tau into a point x in [0,1] using the linear transformation
    % which maps a into 0 and b into 1
    x= (tau-a)./(b-a);
    % Compute Hermite's approximation of f(tau) corresponding to the
    % sub-interval [a,b]
    z(i)=y(j)*p0(x)+y(j+1)*p1(x)+yp(j)*(b-a)*q0(x)+yp(j+1)*(b-a)*q1(x);
end