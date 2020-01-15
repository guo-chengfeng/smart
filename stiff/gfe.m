function unite = gfe(i,j)
%GFE return unit tensor
%   unit = gfe(i) return a 3*1 uint vector 
%   unit = gfe(i,j) return a 3*3 uint tensor
%   Example:
%   unit = gfe(2,3);
%   uint = [ 0 0 0; 0 0 1;0 0 0];
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/23
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
if nargin==1
    if i>3 || i<0
        nnerr.throw('Error: Subscript indices must be real positive integers and smaller than three');
    end
    unite=zeros(3,1);
    unite(i)=1;
end

if nargin==2
    if i>3 || i<0 || j>3 || j<0
        nnerr.throw('Error: Subscript indices must be real positive integers and smaller than three');
    end
    unite=zeros(3,3);
    unite(i,j)=1;
end

end

