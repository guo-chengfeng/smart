function result = gfisvector(sym1)
%GFISVECTOR True for vector
%   GFISVECTOR(V) returns 1 if V is a vector and 0 otherwise.
%
%  Version: V1.0
%  Author : C.F.Guo
%  Time   : 2015/9/23
%  
% ------------------------------NOTE---------------------------------------
%  
% This a subroutine of Seismic Modeling and Research Toolkit (SMART),
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
[nz,nx]=size(sym1);
if (nz==1 && nx>1) || (nx==1 && nz>1)
    result = 1;
else
    result = 0;
end

end

