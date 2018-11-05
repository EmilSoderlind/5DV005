% SIMPLE_SUM_MWE1  Minimal working example
%
% Sum the first n = 1000 terms of the harmonic series in order of ascending
% magnitude using single precision floating point arithmetic

% Define the number of terms
n=1000; 

% Compute the elemments
a=1./linspace(1,n,n); 

% Set the precision and the order of summation
precision='single'; direction='ascend';

% Evaluate the sum ...
[s, flag]=simple_sum(a,n,precision,direction);

% Display the result nicely
fprintf("Sum s = % 16.14f\n",s);