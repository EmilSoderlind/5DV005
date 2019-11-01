% A2F2 Minimal working example for MyChebyshev

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen
%   2018-11-14 Skeleton extracted from working code

% Set number of polynomials
n = 6;

% Set number of sample points
x_size = 101;

% Define sample points
x = -1: 1/x_size:1;

% Generate function values
y = MyChebyshev(n, x);

% Plot all graphs with one command
plot(x, y)

% Adjust axis to make room for legend
axis([-1 1 -1.5 2.5]);
grid on;

% Set labels
xlabel('x (samplepoints)');
ylabel('f(x)');
title('First 6 Chebyshev polynomials');

% Construct and display legend
str=[];
for i=0:n-1
    str=[str strcat("n=",string(i))];
end
legend(str);
