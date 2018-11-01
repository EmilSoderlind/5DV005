% MAKE_SHELLS  Constructs splines representing standard shells

% Load the ascii file
A=importdata('mcg1.txt');

% Compute the corresponding spline
cs=spline(A(:,1),A(:,2));

% This function represents the spline
mcg1=@(x)ppval(cs,x);

%--------------------------------------------------------------------------

% Load the ascii file
A=importdata('mcg2.txt');

% Construct the corresponding spline
cs=spline(A(:,1),A(:,2)); mcg2=@(x)ppval(cs,x);

%--------------------------------------------------------------------------

% Load the ascii file
A=importdata('mcg5.txt');

% Construct the corresponding spline
cs=spline(A(:,1),A(:,2)); mcg5=@(x)ppval(cs,x);

%--------------------------------------------------------------------------

% Load the ascii file
A=importdata('mcg6.txt');

% Construct the corresponding spline
cs=spline(A(:,1),A(:,2)); mcg6=@(x)ppval(cs,x);

%--------------------------------------------------------------------------

% Load the ascii file
A=importdata('mcg7.txt');

% Construct the corresponding spline
cs=spline(A(:,1),A(:,2)); mcg7=@(x)ppval(cs,x);

%--------------------------------------------------------------------------

% Load the ascii file
A=importdata('mcg8.txt');

% Construct the corresponding spline
cs=spline(A(:,1),A(:,2)); mcg8=@(x)ppval(cs,x);

%--------------------------------------------------------------------------

% Save the spline functions
save shells.mat mcg1 mcg2 mcg5 mcg6 mcg7 mcg8

