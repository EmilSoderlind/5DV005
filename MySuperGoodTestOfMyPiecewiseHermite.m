
f = @(x)(3.*x.^2 + 2.*x);
fp = @(x)(6.*x + 2);

s = 1:1/100:200;
y = f(s);
yp = MyDerivs(y, 1/100);
t = 300; %wat is dis

MyPiecewiseHermite(s, y, yp, t)