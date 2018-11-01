% This script is incomplete

% Define the array of numbers
m=2^22; a=1:m; a=1./a;

% Compute all required sums
[s1, mu1, flag1]=my_simple_sum(a,m,'single','ascend');
[s2, mu2, flag2]=
[s3, mu3, flag3]=
[s4, mu4, flag4]=

% Compute accurate approximation of the sum using Kahan's method.
[t, flag]=

% Define the single and double precision unit round off
us=2^(-24); ud=2^(-53);

% Compute the errors 
e1=t-s1; 
e2=; 
e3=; 
e4=; 

% Compute the running error bounds. 
% Remember to use the correct unit roundoff

% Print the output nicely
% The white space in the string '% 16.12e' is deliberate.
fprintf('Precision     Direction      Result                Error                Error bound\n');
fprintf('single        ascend        % 16.12e    % 16.10e\n',s1,e1);
fprintf('single        descend       % 16.12e    % 16.10e\n',s2,e2);
fprintf('double        ascend        % 16.12e    % 16.10e\n',s3,e3);
fprintf('double        descend       % 16.12e    % 16.10e\n',s4,e4);


 