function [s, frac, est, err]=rode(f,a,b,y0,N1,N2,kmax,method,p,sol)

% RODE  Applies Richardson's techniques to ODEs
%
% This function uses Richardson's technique to estimate the error when
% solving the initial value problem
%
%    y'(t) = f(t, y),     a <= t <=b
%     y(a) = y0
%
% using one of the standard Runge-Kutta methods.
%
% CALL SEQUENCE: 
% 
%    [s, frac, est, err]=rode(f,a,b,y0,N1,N2,kmax,method,p,comp,sol)
%
% INPUT:
%   f       a user defined function
%   a,b     specifies the interval
%   y0      the initial condition
%   N1, N2  controls the total number of timesteps, see below
%   kmax    controls the number of refinements, see below
%   method  a string controlling the method used, see rk.m
%   p       the order of the method used
%   comp    do error estimation for this component of the solution
%   sol     an optional function which computes the true solution.
%             
% OUTPUT:
%   s       s(i,j,:) approximations of the ith component of y at time t(j)
%   frac    Richardson's fractions
%   est     Richardson's error estimates
%   err     if the solution is supplied, then err(i) is the true error
%
% The array s contains kmax approximations of the solution. 
%   s(:,:,k) is computed using a total of N1*N2*2^(k-1) time steps.
% This means that
%   s(:,:,1) contains the "worst" approximation
%   s(:,:,2) is better than s(:,:,1)
%   s(:,:,3) is better than s(:,:,2), and so on
%
% MINIMAL WORKING EXAMPLE(s): rode_mwe1, rode_mwe2, rode_mwe3, rode_mwe4
% 
% See also: RDIF, RINT, RK

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%    Dec 2012    Initial programming and better testing
%    Apr 2014    Streamlining and better comments
%    Oct 2014    Modified to fit with the new Runge-Kutta code
%    2014-29-10  Optional exact solution enabled
%    2014-12-04  Variable number of fractions allowed to check behaviour
%    2014-12-05  Improved documentation prior to release of Project 3
%    2014-12-16  Bug found and fixed by several students in MWE
%    2016-06-28  Major revision during yearly review
%                  1) New minimal working examples
%                  2) New documentation
%                  3) Integration of displaytable()
%                  4) Automatic support for multiple dimensions
%                  5) Improved datalayout

% Did the user supply the exact solution for comparison purposes?
if ~exist('sol','var')
    flag=0; % No solution was given
else
    flag=1; % A solution was provided
end

% Determine the number of components in the solution
dim=size(y0,1); 

% We need at least three approximations to begin.
kmax=max(3,kmax);

% Allocate space for the solutions.
s=zeros([dim N1+1 kmax]);

% Overallocate space for the fractions. 
frac=zeros([dim N1+1 kmax]);

% Allocate space for the error estimates.
est=zeros([dim N1+1]);
 
%--------------------------------------------------------------------------
% Compute the different approximations of the solution
%--------------------------------------------------------------------------

% On the coarsest grid there will be N1*N2 time steps.
num=N2;
for k=1:kmax
   % Compute approximation using time step h=(b-a)/(N1*num)
   [t, y]=rk(f,a,b,y0,N1,num,method); s(:,:,k)=y; % reshape(y,[dim N1+1]);
   % Increase NUM with a factor 2. 
   num=num*2;
end

% s(:,:,1) contains the worst approximations, s(:,:,2) is better and so on

%--------------------------------------------------------------------------
% Compute Richardson's fractions
%--------------------------------------------------------------------------
for j=3:kmax
  frac(:,:,j)=(s(:,:,j-1)-s(:,:,j-2))./(s(:,:,j)-s(:,:,j-1));
end

%--------------------------------------------------------------------------
% Compute Richardson's error estimates assuming the order p is correct
%--------------------------------------------------------------------------

factor=2^p-1; est=(s(:,:,kmax)-s(:,:,kmax-1))/factor;

%**************************************************************************
%    WARNING: The most common mistake is to use the wrong value of p
%**************************************************************************

% Evaluate the true solution, if known and compute the "exact" error
if (flag==1)
    % Evaluate the true solution
    y=sol(t);
    % Compute the "exact" error
    err=y-s(:,:,kmax);
    % Evaluate the quality of the error estimate
    rel=(err-est)./err; count=floor(-log10(2*abs(rel)));
else
    % Dummy initialization of the err to keep MATLAB quiet
    err=[];
end

% Allocate data for the output
if (flag==0)
    data=zeros(N1+1,kmax+1);
else
    data=zeros(N1+1,kmax+3);
end

%--------------------------------------------------------------------------
% Determine all column headers, column widths and formats
%--------------------------------------------------------------------------

% Define column headings
colheadings={'time','approximation'};
for k=kmax-3:-1:0
    % Construct string
    string=strcat('F_(',num2str(2^k,'%d'),'h)');
    colheadings=[colheadings, {string}];
end
colheadings=[colheadings, {'Error estimate'}];

% Set column widths
wids=[6 24 10*ones(1,kmax-2) 24];

% Define column formats
fms={'.2f','.16e'};
% Append format specifiers for Richardson's fractions
for k=1:kmax-2
    fms=[fms, {'.6f'}];
end
% Append format specifier for Richardson's error estimate
fms=[fms, {'.16e'}];

% Has the true solution been given
if flag==1
    % More column headers are needed
    colheadings=[colheadings, {'Error','Comparison'}];
    % These extra columns need widths ...
    wids=[wids 24 10];
    % ... and format specifiers
    fms=[fms,{'.16e','d'}];
end

%--------------------------------------------------------------------------
% Print the computed data nicely on the screen
%--------------------------------------------------------------------------

% Loop over all components of the solution 
for j=1:dim
    % Print header
    fprintf('\nData related to component %d\n\n',j);
    % Select data
    data(:,1:2)=[t' s(j,:,1)'];
    % Add Richardson's fractions to the data set
    for k=3:kmax
       data(:,k)=frac(j,:,k)';
    end
    % Add Richardson's error estimate to the data set
    data(:,kmax+1)=est(j,:)';
    % Has the solution been supplied
    if (flag==1)
        % Add the true error to the data set
        data(:,kmax+2)=err(j,:)';
        % Add the comparison of the error estimate to the error
        data(:,kmax+3)=count(j,:)';
    end
    displaytable(data,colheadings,wids,fms);
end
    