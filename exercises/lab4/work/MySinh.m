function y = MySinh(x)

m = length(x);
y = zeros(1, m);

for i = 1:m
    if   x(i) <= -log(2)/2 || x(i) >= log(2)/2
        y(i) = (exp(x(i)) - exp(-x(i))) / 2;
    else
        j=0:50;
        y(i) = sum(mod(j, 2) .* (x(i)) .^ j ./ factorial(j));
    end
end


