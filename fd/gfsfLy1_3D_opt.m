function  outp= gfsfLy1_3D_opt(inp,dy)
% GFSFLY1_3D_OPT is 3D 12th-order forward staggered-grid finite-difference 
%   operator for 1st-order y-axis derivative.
%
%   call:
%
%   dat1 = gfsfLy1_3D_opt(dat,dy).
%       dat is the 3D matrix;
%       dy is the spatial step in Y-direction
%
%   gfsbLx1_3D_opt,gfsbLy1_3D_opt,gfsbLz1_3D_opt,gfsfLx1_3D_opt,
%   gfsfLy1_3D_opt,gfsfLz1_3D_opt are fix 12th-order staggered-grid 
%   finite-difference operators.
% 
%   The suffix 'opt' means adopting optimized finite-difference coefficients.
%  
%   Reference: Optimal staggered-grid finite-difference schemes based 
%   onleast-squares for wave equation modelling, 2014, LiuYang
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
% China University of Petroleum(East China))
% 
% ------------------------------END----------------------------------------
x=zeros(1,12,1);
x(1,:,1)=[0.3745306e-3 -0.2262285e-2 0.8741572e-2  -0.2997288e-1 0.1174969e0 -0.1247576e1 0.1247576e1 -0.1174969e0 0.2997288e-1 -0.8741572e-2 0.2262285e-2 -0.3745306e-3 ];
indy=1/dy;
temp=convn(inp,x)*indy;
outp=temp(:,6:end-6,:);
end

