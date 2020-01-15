function  outp= sbLx(inp,dx)
% SBLX is abbreviation of GFSBLX1_OPT for convenience.
% GFSBLX1_OPT is 2D 12th-order backward staggered-grid finite-difference 
%   operator for 1st-order x-axis derivative.
%
%   call:
%
%   dat1 = gf_sbLx1_opt(dat,dx).
%       dat is the 1D(row) or 2D matrix;
%       dx is the spatial step in X-direction
%
%   sbLx,sbLz,sfLx,sfLz are fix 12th-order staggered-grid finite-difference 
%   operators based on folling scheme:
% 
%   (Note that the follwing parameters definition style is just the one 
%   that I sugguset to use, these staggered-grid finite-difference operators 
%   can also be used in other staggered-grid schemes!)
%
%   1---------------2 ---------------1          
%   |               |                |          1:Txx,Tzz,C
%   |               |                |          2:Vx,rho
%   |               |                |          3:Vz,rho
%   |               |                |          4:Txz,C
%   |               |                |
%   3---------------4 ---------------3          
%   |               |                |        
%   |               |                |                 
%   |               |                |          
%   |               |                |
%   |               |                |
%   1---------------2 ---------------1  
%
%   Calculation rules 
%       As for grid 1, grid 2 and grid 3 are forward
%       As for grid 4, grid 2 and grid 3 are backward
%       As for grid 2, grid 4 is forward and grid 1 are backward
%       As for grid 3, grid 4 is forward and grid 1 are backward
% 
%   The suffix 'opt' means adopting optimized finite-difference coefficients.
%  
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11 
%
%   Reference: Optimal staggered-grid finite-difference schemes based 
%   onleast-squares for wave equation modelling, 2014, LiuYang
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

x=[0.3745306e-3 -0.2262285e-2 0.8741572e-2  -0.2997288e-1 0.1174969e0 -0.1247576e1 0.1247576e1 -0.1174969e0 0.2997288e-1 -0.8741572e-2 0.2262285e-2 -0.3745306e-3 ];
[l,c]=size(inp);
temp=conv2(inp,x)/dx;
outp=temp(1:l,1+6:c+6);

end

