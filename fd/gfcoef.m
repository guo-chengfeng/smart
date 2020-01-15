function am=gfcoef(l)
% GFCOEF calculates the 2L-order central finite-difference coefficients
%
%   call:
%  
%   coefs=gfcoef(L); L is the half order of finite-difference scheme
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
    bm=1;cm=1;dm=1;
    for i=1:m-1
        bm=bm*i^2;
    end
    for i=m+1:l
        bm=bm*i^2;
    end
    for i=1:m-1
        cm=cm*(m^2-i^2);
    end
    for i=m+1:l
        dm=dm*(i^2-m^2);
    end
    am(m)=(-1)^(m+1)*bm/2/m/cm/dm;
end