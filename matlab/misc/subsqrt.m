x=linspace(0,1,1001)*2^-22;
f=@(x)sqrt(4+x.^2)-2;
plot(x,f(x));