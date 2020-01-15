function [data,hdr] = gfreadsegyhdr(fileName,p_start,p_end )
% GFREADSEGYHDR reads trace header and data from the SEGY file
%
%   call:
%
%   [data,hdr] = gfreadsegyhdr(fileName) reads whole data
%
%   [data,hdr] = gfreadsegyhdr(fileName,startAt) reads data from startAt 
%       trace to the end of the file 
%
%   [data,hdr] = gfreadsegyhdr(fileName,startAt,endAt) reads data from 
%   	startAt trace to endAt trace
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
if nargin==1
hdr=gfreadhdr(fileName);
data=gfreadsegy(fileName);
end
if nargin==2
hdr=gfreadhdr(fileName,p_start);
data=gfreadsegy(fileName,p_start);
end
if nargin==3
hdr=gfreadhdr(fileName,p_start,p_end);
data=gfreadsegy(fileName,p_start,p_end);
end

end



