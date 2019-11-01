function [x, flag, it, a, b, his, y, reb]=MyRoot(p,a0,b0,delta,eps,maxit)

% A3F3  Finds roots of polynomials using the bisection method
%
% INPUT:
%   p        array of coefficients used by my_horner
%   a0, b0   the initial bracket
%   delta    return if current bracket is less than delta
%   eps      return if current residual is less than epsilon
%   maxit    return after maxit iterations
%   
% OUTPUT:
%   x      final approximation of the root
%   flag   a flag signaling succes or failure, 
%              flag  = -2  the initial bracket is bada
%              flag  = -1  the sign of f(a0) or f(b0) cannot be trusted
%              flag  =  0  maxit iterations completed without convergence
%              flag  >  0  then convergence has been achieved and if 
%                 bit 0 set   then the last bracket is shorter than delta
%                 bit 1 set   then the last function value is bounded by eps
%                 bit 2 set   then the sign of the last function value cannot
%                             be trusted
%   it     the number of iterations completed
%   a, b   a(j) and b(j) form the jth bracket around his(j)
%   his    a vector containing all computed approximations of the root
%   y      the computed values of y=p(his)
%   reb    the running error bounds for y
%
% MIMIMAL WORKING EXAMPLE: Missing

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-14 Skeleton extracted from working code MyRoot
%   2018-11-25 Skeleton extracted and functonality added by Betty Törnkvist, 
%              Jonas Sjödin and Emil Söderlind

% Initialize the flag.
flag=0;

% Dummy initialization of *all* output arguments
x=NaN; it=0;
a=zeros(maxit,1); 

b=zeros(maxit,1); 
his=zeros(maxit,1); 
y=zeros(maxit,1); 
reb = zeros(maxit, 1);

% Initialize search bracket (alpha,beta) such that alpha <= beta
alpha = a0;
beta = b0;

% Compute fa=p(alpha) and fb= p(beta) and associated error bounds

[fa, ~, rebfa]=my_horner(p,alpha);
[fb, ~, rebfb]=my_horner(p,beta);

% Investigate if the flag should be -2 or -1
if sign(fa) == sign(fb)
    flag = -2;
end
if rebfa > abs(fa) || rebfb > abs(fb)
    flag = -1;
end


if (flag<0)
    % The initial bracket is either bad or cannot be judged
    return
end
    
% Main loop
for j=1:maxit
   
    % Record the current search bracket
    a(j)=alpha; b(j)=beta;
    
    % Carefully compute the midpoint c of the current search bracket
    c = alpha + ((beta - alpha) / 2);
    
    % Evaluate fc = p(c) and the running error bound for fc
    [fc, ~, rebfc]=my_horner(p,c);
    
    % Save the current values
    x=c; his(j)=c; y(j)=fc; reb(j)=rebfc;
    
    
    % Check for small bracket
    if abs(beta-alpha) < delta
        flag = flag+1;
    end
    
    % Check for small residual
    if abs(fc) < eps
        flag = flag+2;
    end
    
    % Check if the computed sign of the p(c) cannot be trusted
    if rebfc > abs(fc)
        flag = flag+4;
    end
    
    % Check if we can break out of the loop
    if flag>0
        % Yes, there is no reason to continue
        break
    end
    
    %----------------------------------------------------------------------
    % At this point we know that we need more iterations.
    %----------------------------------------------------------------------
    
    % Rebracket the root and recycle the old function values
    if sign(fa)*sign(fc)==-1
        beta=c; fb=fc;
    else
        alpha=c; fa=fc;
    end
end

% Shrink the output to avoid tails of unnecessary zeros
% 1.000000005 ~ 1
a = a(1:j);
b = b(1:j);
his = his(1:j);
y = y(1:j);
reb = reb(1:j);

% Return the number of iterations
it=j;