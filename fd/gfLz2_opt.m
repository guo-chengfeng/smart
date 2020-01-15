function r = gfLz2_opt(s,dz)
% GFLZ2_OPT is 2D 8th-orser central-grid finite-difference operator for 
%   2nd-order z-axis derivative.
%
%   call:
%
%   dat1 = gfLz2_opt(dat,dz).
%       dat is the 1D(row) or 2D matrix;
%       dz  is the spatial step in Z-direction
%
%   The suffix 'opt' means adopting optimized finite-difference coefficients.
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
% Copyright(C)2015 Anisotropic and Multicomponent (AN&MC) Sesimic Data 
% Processing Laboratory, China University of Petroleum(East China)
% 
% ------------------------------END----------------------------------------
z=[-0.4946851e-2 0.4445392e-1 -0.2554615e0 0.1700010e1 -0.2968111e1 0.1700010e1 -0.2554615e0 0.4445392e-1 -0.4946851e-2]';
[l,c]=size(s);
dzdz=1/dz/dz;
temp=conv2(s,z)*dzdz;
r=temp(1+4:l+4,1:c);
end

