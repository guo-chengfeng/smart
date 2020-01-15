function r = Lz2(s,dz)
% GFLZ2 is 2D 8th-orser central-grid finite-difference operator for 
%   2nd-order z-axis derivative.
%
%   call:
%
%   dat1 = Lx2(dat,dz).
%       dat is the 1D(row) or 2D matrix;
%       dz  is the spatial step in Z-direction
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/12 
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

z=[-1/560 8/315 -1/5 8/5 -205/72 8/5 -1/5 8/315 -1/560]';
dzdz=dz*dz;
r=conv2(s,z,'same')/dzdz;

end

