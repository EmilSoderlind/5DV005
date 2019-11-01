
x = linspace(-3, 3, 101);

T = sinh(x);
O = MySinh(x);

rel = (T - O) ./ T;


find (rel < 10^-15)