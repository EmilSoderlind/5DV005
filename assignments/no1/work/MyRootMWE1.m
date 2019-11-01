% A2F2 Minimal working example for MyChebyshev

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen
%   2018-11-14 Skeleton extracted from working code
%   2018-11-25 Skeleton extracted and functonality added by Betty Törnkvist, 
%              Jonas Sjödin and Emil Söderlind

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
x = zeros(n, 1);

% Chebyshev polynomial of degree 10
y = [-1, 0, 50, 0, -400, 0, 1120, 0, -1280, 0, 512];

m = 101;
lin = linspace(-1, 1, m);

inx = 1;
maxit = 100000;
delta = 2 * 10^-13;
epsilon = 10^-13;

for i=1:m-1
    % Calculate the x:th root of Chebyshev polynomial of degree n
    
    [retroot, retflag, retit, reta, retb, rethis, rety, retreb] = MyRoot(y, lin(i), lin(i+1), delta, epsilon, maxit);    
   
    if isnan(retroot)
        continue
    end
    
    root(inx) = retroot;
    flag(inx) = retflag;
    it(inx) = retit;
   
    % Save values for printing later on
    a(inx) = reta(retit);
    b(inx) = retb(retit);
    his(inx) = rethis(retit);
    res(inx) = rety(retit);
    reb(inx) = retreb(retit);
    inx = inx + 1;
end

% Set if root can be trusted
trust = reb < res;

% Assign data that should be printed 
data = [transpose(1:n), flag, it, a, b, root, res, reb, trust];
% Set headers for each column
colheaders = {'idx', 'flag', 'it', 'a', 'b', 'root', 'residual', 'reb', 'trust'};
% Set width of each column
width = [6, 4, 3, 12, 12, 12, 12, 12, 5];
% Format numbers
fms={'d','d','d','.5e','.5e', '.5e', '.5e', '.5e', 'd'};

displaytable(data, colheaders, width, fms);

T = flip(cos((2*(1:10) - 1) .* pi/(2*n)));
O = transpose(root);
R = abs((T - O) ./ T);

RelativeErrorLargerThan = find(R > 10^-13)
RelativeError = R
