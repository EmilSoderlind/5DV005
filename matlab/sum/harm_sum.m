function y=harm_sum(kmax)

% HARM_SUM Demonstrate how to field test numerical routines
%
% Sums up to 2^kmax terms of the harmonic series using four different
% methods and performs a field analysis of the output based on simple
% mathematical properties of the harmonic series. Finally the entire
% output is printed nicely
% 
% CALL SEQUENCE y=harm_sum(kmax)
%
% INPUT:
%   kmax  : compute the sum of the first 2^k terms, k=1,2,...kmax
%
% OUTPUT:
%   y     : an array of dimensions kmax by 9, such that
%             y(k,1) = k
%           The sum of the first 2^k elements are computed and stored:
%             y(k,2) = simple_sum with option ascend
%             y(k,3) = simple_sum with option descend
%             y(k,4) = tree_sum
%             y(k,5) = kahan_sum
%           Moreover, the following successive differences are computed:
%             y(k,6) = y(k,2)-y(k-1,2)
%             y(k,7) = y(k,3)-y(k-1,3)
%             y(k,8) = y(k,4)-y(k-1,4)
%             y(k,9) = y(k,5)-y(k-1,5)
%
% In *exact* arithmetic, the successive difference tend monotonically to
% log(2) and are bounded from above by log(2)!
%
% MINIMAL WORKING EXAMPLE: y=harm_sum(22);

% CONCEPT: Professor Ole Oesterby, DAIMI, Aarhus University
%
% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen
%  201X        Early versions developed by 5DV005 students
%  2014-11-03  Formating finalized and enforced.
%  2016-06-30  Documentation improved during yearly review

% Allocate space
y=zeros(kmax,9); n=2^kmax;

% Select single precision
precision='single';

for k=1:kmax
    % Display progress indicator.
    fprintf('Iteration % 4d\n',k);
    % Generate the array
    j=linspace(1,2^k,2^k); a=1./j;
    % Save the value of k
    y(k,1)=k;
    % Compute the many different sums
    [aux, flag]=simple_sum(a,2^k,precision,'ascend');  y(k,2)=aux;
    [aux, flag]=simple_sum(a,2^k,precision,'descend'); y(k,3)=aux;
    [aux, flag]=tree_sum(a,k,precision);               y(k,4)=aux;
    [aux, flag]=kahan_sum(a,2^k,precision);            y(k,5)=aux;
end

% Analysis
for k=2:kmax
    for j=2:5
        y(k,4+j)=y(k,j)-y(k-1,j); y(k,4+j)=y(k,4+j);
    end
end

% Nice printing
fprintf('\n\n');
fprintf('          raw data                                         |    successive differences                              \n');
fprintf('--------------------------------------------------------------------------------------------------------------------\n');
fprintf('    k     ascend       descend      tree         kahan     |    ascend       descend      tree         kahan        \n');
fprintf('--------------------------------------------------------------------------------------------------------------------\n');
for k=1:kmax
    fprintf(' % 4d  %12.7f %12.7f %12.7f %12.7f | %12.7f %12.7f %14.10f %14.10f \n',y(k,1:9));
end
    

   