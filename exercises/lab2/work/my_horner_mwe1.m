
%x = 2+(2^(-15)): 101 : 2+(2^(15));
% Interval start and end
interval_start = 2 - 2^(-15);
interval_end = 2 + 2^(-15); 

x = linspace(interval_start,interval_end,101);
%x= 2 + [(2^(-15)) :101: (2^(15)) ];

% Polynomials to plot
p = @(x)(x-2).^3;

%q = @(x)x.^3 -6.*x.^2 + 12.*x - 8;
q_coeff = [-8,12,-6,1];

% Performing my_horner on q:s coefficients
[y,aeb,reb] = my_horner(q_coeff,x);


% Plotting p and q (y)
plot(x,p(x),x,y);
legend({'p(x)','HORNER: q(x)'},'Location','north')


% Plotting absolute value of q and its aeb + reb.
plot(x,abs(y),x,aeb,x,reb);
legend({'ABS(HORNER: q(x))','Apriori error','Running error'},'Location','north')

find(abs(y) > abs(reb))