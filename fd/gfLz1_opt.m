function  outp= gfLz1_opt( inp,dz)
% LZ is a 2D 12-order central-grid finite-difference operator for 
%   1st-order x-axis derivative using the optimized FD coefficients
%   provided by QiangZhang (2015)
%
%   call:
%
%   out = gfLz1_opt(in,dz).
%       dat is the 1D(column) or 2D matrix;
%       dx is the spatial step in Z-direction
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


a=[ 0.948470283603429 -0.402686651335679 0.202459270014221 -0.097773021984250 ...
    0.042186657354830 -0.011936222604282];
z=[-a(end:-1:1) 0 a]';
idz=-1/dz;
outp=conv2(inp,z,'same')*idz;

end

