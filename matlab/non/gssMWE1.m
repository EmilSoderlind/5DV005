% gssMWE1  MWE for Golden Section search algorithm

% Define interval
alpha=0; beta=1;

% Define target function, obvious maximum at x=0.5
f=@(x)x.*(1-x);

% Set tolerance
tol=1e-15;

% Set maximum number of iterations
maxit=100;

% Run the experimental version of gss
[x, y, flag, it, a, b]=gss(f,alpha,beta,tol,maxit);