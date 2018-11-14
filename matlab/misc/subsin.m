x=linspace(-1,1,1001)*2^(-22);
T=@(x)x-sin(x);
N=@(x)x.^3;
f=@(x)T(x)./N(x);
plot(x,f(x));