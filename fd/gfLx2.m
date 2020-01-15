function r = gfLx2(s,dx,M)
% GFLX2 is 2D 2Mth-order central-grid finite-difference operator for
%   2nd-order x-axis derivative.
%
%   call:
%
%    out = gfLx2(in,dx,M).
%       in  is the 1D(row) or 2D matrix;
%       dx  is the spatial step in X-direction
%       M   represents 2Mth-order, default: M=4
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11
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
    x=[-1/560 8/315 -1/5 8/5 -205/72 8/5 -1/5 8/315 -1/560];
else
    cm=fdcoef(2,M);
    x=[cm(end:-1:2) cm];
end
idx=1/dx/dx;
r=conv2(s,x,'same')*idx;
end

