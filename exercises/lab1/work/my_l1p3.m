% This script is incomplete

% Define the array of numbers
m=2^22; a=1:m; a=1./a;

% Compute all required sums
[s1, flag1,error1]=my_simple_sum(a,m,'single','ascend');
[s2, flag2,error2]=my_simple_sum(a,m,'single','descend');
[s3, flag3,error3]=my_simple_sum(a,m,'double','ascend');
[s4, flag4,error4]=my_simple_sum(a,m,'double','descend');

% Compute accurate approximation of the sum using Kahan's method.
[t, flag]=kahan_sum(a,m,'double');

% Compute the errors 
e1=t-s1; 
e2=t-s2;
e3=t-s3; 
e4=t-s4; 

% Print the output nicely
% The white space in the string '% 16.12e' is deliberate.
% What does it do to positive/negative numbers?
fprintf('Precision     Direction      Result                Error                Error bound\n');
fprintf('single        ascend        % 16.12e    % 16.10e   % 16.12e\n',s1,e1,error1);
fprintf('single        descend       % 16.12e    % 16.10e   % 16.12e\n',s2,e2,error2);
fprintf('double        ascend        % 16.12e    % 16.10e   % 16.12e\n',s3,e3,error3);
fprintf('double        descend       % 16.12e    % 16.10e   % 16.12e\n',s4,e4,error4);


 