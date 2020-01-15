function result = gfvtdotprod(sym1,sym2)
%GFVTDOTPROD return dot product of a vector and a tensor  
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


result=sym1;
for k=1:3
    result(k)=0;
    for i=1:3
        for j=1:3
            result(k)=result(k)+sym1(i)*sym2(j,k)*gfdelta(i,j);
        end
    end
end

end

