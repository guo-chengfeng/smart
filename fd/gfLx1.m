function  outp= gfLx1(inp,dx,M)
% GFLX1 is a 2D 2Mth-order central-grid finite-difference operator for 
%   1st-order x-axis derivative.
%
%   call:
%
%   out = gfLx1(in,dx,M).
%   in  is the 1D(row) or 2D matrix;
%   dx  is the spatial step in X-direction
%   M   represents 2Mth-order, default: M=6
%
%   
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11 
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

if nargin<3
    cm=[0.857142857142857  -0.267857142857143   0.079365079365079 ...  
        -0.017857142857143   0.002597402597403  -0.000180375180375];
else
    cm=gfcoef(M);
end
x=[-cm(end:-1:1),0,cm];
idx=-1/dx;
outp=conv2(inp,x,'same')*idx;

end

