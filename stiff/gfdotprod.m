function result = gfdotprod(sym1,sym2)
%GFDOTPROD return a dot product of two tensors [1- or 2-order]
%   GFDOTPROD(sym1,sym2) returns a dot product of two tensor sym1,sym2
%   Note: Dimensions of sym1 and sym2 are 3,defaultly
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

% sclar product 
if gfiscalar(sym1) || gfiscalar(sym2)
    result = sym1*sym2;
% dot product for two vectors    
elseif gfisvector(sym1) && gfisvector(sym2)
    result=0;
    for i=1:3
    result = result+sym1(i).*sym2(i);
    end
% left dot product 
elseif gfisvector(sym1) && gfistensor(sym2)
    result=zeros(3,1);
    for k=1:3
        for i=1:3
            for j=1:3
                result = result + sym1(i)*sym2(j,k)*gfdelta(i,j)*gfe(k);
            end
        end
    end
 % right dot product
elseif gfistensor(sym1) && gfisvector(sym2)
    result=zeros(3,1); 
    for i=1:3
        for j=1:3
            for k=1:3
                result = result + sym1(i,j)*sym2(k)*gfdelta(j,k)*gfe(i);
            end
        end
    end
  % tensor product
elseif gfistensor(sym1) && gfistensor(sym2)
    result = sym1*sym2;
else
    nnerr.throw('Error: can not handle the arguemets');
end

end

