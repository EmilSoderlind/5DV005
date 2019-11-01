% Specify number of terms
n=2^20;

% Indices;
j=1:n;

% Initialize the arrays a and b
a=1./j.^4; 
b=((-1).^j)./j;

% Compute all sums and all error bounds
tic
[s1, reb1]=my_recursive_sum(single(a), n);
toc
fprintf('  a        single      %16.14e  % 16.14e  %16.14e\n',s1,e1,reb1);
