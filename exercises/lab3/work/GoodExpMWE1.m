clear; clf; close all;
x = linspace(-30, 30, 1025);
A = GoodExp(x);
T = exp(x);
R = abs((T - A) ./ T);
plot(x, A)
grid on;
xlabel('x');
ylabel('GoodExp(x)');
legend('A(X)')

figure()
plot(x, log10(R))
grid on;
xlabel('x');
ylabel('R(X)');
legend('Relative error');
u = 2^-53;

max(R/(12*u))