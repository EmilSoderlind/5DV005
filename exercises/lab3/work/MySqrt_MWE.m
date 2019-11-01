clear;

x = linspace(10^-5,10^5,1010);

O = MySqrt(x);
T = sqrt(x);

reEr = abs((T - O)./T);

plot(log10(x),log10(reEr));
axis([-5 5 -16 -15.65]);
grid on;
