function y=a2f6(x)

% A2F6   Computes the height of a simple landscape
%
% Without any documentation the reader is forced to read and translate
% the entire code. This is frightfully annoying in the long run, right?

% Fill the array y with zeros
y=zeros(size(x));

% Isolate all the indices of x values between 13000 and 15000
idx=14000<=x & x<=16000;

% Define a half-circle with center at 14000 and radius 1000
% Admittedly, this is an odd hill ...
y(idx)=sqrt(1e6-(x(idx)-15000).^2);