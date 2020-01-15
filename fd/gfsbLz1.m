function  outp= gfsbLz1( inp,dz,M)
% GFSBLZ1 is 2D 2Mth-order backward staggered-grid finite-difference 
%   operator for 1st-order z-axis derivative.
%
%   call:
%
%   dat1 = gfsbLz1(dat,dz,M).
%       dat is the 1D(column) or 2D matrix;
%       dx  is the spatial step in Z-direction
%       M   represents 2Mth-order,default: M=6
%
%   gfsbLx1,gfsbLz1,gfsfLx1,gfsfLz1 are 2Mth-order
%   staggered-grid finite-difference operators based on folling scheme:
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
M=6;
end
cm=gfstcoef(M);
z=[-cm(end:-1:1),cm ]';
[l,c]=size(inp);
temp=conv2(inp,z)/dz;
outp=temp(1+M:l+M,1:c);
end

