clear; clf; close all;
x = linspace(-30, 30, 1025);
A = BadExp(x);
T = exp(x);
R = abs((T - A) ./ T);
plot(x, A)
grid on;
xlabel('x');
ylabel('BadExp(x)');
legend('A(X)')

figure()
plot(x, log10(R))
grid on;
xlabel('x');
ylabel('R(X)');
legend('Relative error');
u = 2^-53;
vec = find((R < u))
vec(1:10)

x(find(A < 0))