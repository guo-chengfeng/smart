function am=gfstcoef(l)
% GFSTCOEF calculates the 2L-order staggered-grid finite-difference 
%   coefficients
%
%   call:
%
%   coef=gfstcoef(L); returns the 2L-order staggered-grid finite-difference 
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2013/9/11 
%
% ------------------------------NOTE---------------------------------------
%
% This is a subroutine of Seismic Modeling and Research Toolkit (SMART),
% It is illegal for you to use this software tool (Seismic Modeling and 
% Research Toolkit,SMART) for a purpose other than non-profit education 
% or research UNLESS you are authorized by the Seismic Modeling Project.If 
% you find any problems, please connect the Author(s): chf_guo@163.com
% 
% by C.F. Guo, 2015
% 
% Copyright(C) 2015 Elastic Wave Expolration Project (EWEP)
% China University of Petroleum(East China)
% 
% ------------------------------END----------------------------------------
for m=1:l
    bm=1;cm=1;
    for i=1:m-1
        bm=bm*(2*i-1)^2;
    end
    for i=m+1:l
        bm=bm*(2*i-1)^2;
    end
    for i=1:m-1
        cm=cm*((2*m-1)^2-(2*i-1)^2);
    end
    for i=m+1:l
       cm=cm*((2*m-1)^2-(2*i-1)^2);
    end
    am(m)=(-1)^(l+1)*bm/((2*m-1)*cm);
    
end