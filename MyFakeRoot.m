% A2F2 Minimal working example for MyChebyshev

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen
%   2018-11-14 Skeleton extracted from working code
%   2018-11-25 Skeleton extracted and functonality added by Betty 
%                Törnkvist, Jonas Sjödin and Emil Söderlind

% Set Chebyshev degree
n = 10;

% Define sample points
it = zeros(n, 1);
flag = zeros(n, 1);
a = zeros(n, 1);
b = zeros(n, 1);
his = zeros(n, 1);
root = zeros(n, 1);
res = zeros(n, 1);
reb = zeros(n, 1);

% Chebyshev polynomial of degree 10
y = [-1, 0, 50, 0, -400, 0, 1120, 0, 1280, 0, 512];



for i=1:n
    % Calculate the x:th root of Chebyshev polynomial of degree n
    x = cos((2*i - 1) * pi/(2*n));
    
    sendInA = x - 0.0001
    sendInB = x + 0.0007
    x
    
    % Find the correct root with a REB around x
    [root(i), flag(i), it(i), a_i, b_i, his_i, res_i, reb_i] = MyRoot(y, x - 0.0001, x + 0.0007, 10^-13, 10^-13, 1000);    
    
    flag(i)
   
    % Save values for printing later on
    a(i) = a_i(it(i));
    b(i) = b_i(it(i));
    his(i) = his_i(it(i));
    res(i) = res_i(it(i));
    reb(i) = reb_i(it(i));
    
end

% Set if root can be trusted
trust = abs(reb) < abs(res);

% Assign data that should be printed 
data = [transpose(1:n), flag, it, a, b, root, res, reb, trust];
% Set headers for each column
colheaders = {'idx', 'flag', 'it', 'a', 'b', 'root', 'residual', 
    'reb', 'trust'};
% Set width of each column
width = [6, 4, 3, 12, 12, 12, 12, 12, 5];
% Format numbers
fms={'d','d','d','.5e','.5e', '.5e', '.5e', '.5e', 'd'};

displaytable(data, colheaders, width, fms);

find(abs(reb) < 10^-13)