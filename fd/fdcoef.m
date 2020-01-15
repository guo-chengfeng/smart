function c = fdcoef(k,N,opt)
% Compute coefficients for finite difference approximation for the
% derivative of order k for central or staggered grid.
%   
%   c=fdcoef(k,N,opt)
%     k: k-order derivative
%     N: 2N-order approximation
%     opt: 'central' for central-grid; 'staggered' for staggered-grid
%
%   See also fdcoeffF gfcoef gfstcoef
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2013/9/11 

if nargin<3
    opt='central';
end
    xbar=0;
if strcmp(opt,'staggered')
    x=-N+0.5:1:N-0.5;
    c=fdcoeffF(k,xbar,x);
    c(1:N)=[];
else
    x=-N:1:N;
    c=fdcoeffF(k,xbar,x);
    c(1:N)=[];
end

end

