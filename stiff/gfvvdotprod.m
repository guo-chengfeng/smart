function result = gfvvdotprod(sym1,sym2)
%GFVVDOTPROD return dot product of two vectors
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11 
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
class1=class(sym1);
class2=class(sym2);
size1=size(sym1);

if ~(strcmp(class1,'sym') && strcmp(class2,'sym'))
    nnerr.throw('Error: Two arguements must be sym class');
end

if size1(1)*size1(2)~=size1(1) && size1(1)*size1(2)~=size1(2)
    nnerr.throw('Error: The 1 arguement must be a vector');
end

result=sum(sym1.*sym2);

end

