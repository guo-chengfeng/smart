function result = gfkron(sym1,sym2)
%GFKRON Kronecker tensor product
%    gfkron(X,Y) is the Kronecker tensor product of X and Y.
%    The result is a large matrix formed by taking all possible
%    products between the elements of X and those of Y. For
%    example, if X is 2 by 3, then kron(X,Y) is
% 
%       [ X(1,1)*Y  X(1,2)*Y  X(1,3)*Y
%         X(2,1)*Y  X(2,2)*Y  X(2,3)*Y ]
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
result=kron(sym1,sym2);

end

