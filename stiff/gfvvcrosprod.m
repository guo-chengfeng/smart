function result = gfvvcrosprod( sym1,sym2 )
%GFVVCROSPROD return cross product of two vectors
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

if ~(strcmp(class1,'sym') && strcmp(class2,'sym'))
    nnerr.throw('Error: Two arguements must be sym class');
end


result = sym(zeros(3,1));
for k=1:3
    for i=1:3
        for j=1:3
        result(k)=result(k)+gfricci(i,j,k)*sym1(i)*sym2(j);
        end
    end
end
end

