% A2F2 Minimal working example for A1F1

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen
%   2018-11-14 Skeleton extracted from working code

% Set number of polynomials


% Set number of sample points


% Define sample points


% Generate function values


% Plot all graphs with one command


% Adjust axis to make room for legend


% Construct and display legend
str=[];
for i=0:n-1
    str=[str strcat("n=",string(i))];
end
legend(str);
