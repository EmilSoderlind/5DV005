function y=MyLog(alpha)

% THE ENTIRE HEADER IS MISSING

% Isolate significand f and exponent e such that alpha=f*2^e
[f, e]=log2(alpha);

% Translate f, e into standard form such that 1<=f<2
f=f*2; e=e-1;

% Define coefficients for the initial guess
a = log(2);
b = -(a + log(a) + 1) ./ 2;

% Define the initial guess
x=a*f+b;

% Define the number of Newton iterations
n = 100;

% Do n Newton iterations for all components of x
for i=1:n
    % Determine exponential
    ex = exp(x);
    
    % Do Newton step
    x = x - (ex - f) ./ ex;
end

% Do the final adjustment of the output
y = log(f) + log(2)*e;