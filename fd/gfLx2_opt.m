function r = gfLx2_opt(s,dx)
% GFLX2_OPT is 2D 8th-order central-grid finite-difference operator for 
%   2nd-order x-axis derivative.
%
%   call:
%
%   out = gfLx2_opt(in,dx).
%       in  is the 1D(row) or 2D matrix;
%       dx  is the spatial step in X-direction
%
%   The suffix 'opt' means adopting optimized finite-difference coefficients.
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/12 
%  
%   Reference: Globally optimal finite-difference schemes based on least 
%   squares, 2012, LiuYang
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
x=[-0.4946851e-2 0.4445392e-1 -0.2554615e0 0.1700010e1 -0.2968111e1 0.1700010e1 -0.2554615e0 0.4445392e-1 -0.4946851e-2];
dxdx=1/dx/dx;
r=conv2(s,x,'same')*dxdx;
end

