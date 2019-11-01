function y=BadExp(x)

% BADEXP  Very bad implementation of some function.

% Notice who annoying it is when the author does not include information
% about the function? The reader has to read the entire code ...

% This tolerance is reasonable for double precision
tol=2^(-53);

% Initialize the output array
y=zeros(size(x)); 

% Initialize the zeroth term of the Taylor series
term=ones(size(x)); 

% Initialitze counter
it=0;

% Sum terms until the next term is very small relative to the current sum.

while max(abs(term ./ y)) > tol
    % Add the current term to the current approximation
    y=y+term;
    % Increment counter
    it=it+1;
    % Compute the next term
    term=(term.*x)/it;
end