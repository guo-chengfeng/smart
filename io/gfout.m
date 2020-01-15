function gfout(data,varargin)
%GFOUT exports data to binary SEGY file
%
%   call:
%
%   gfout(data) writes data to a default IEEE float-pointing file whose
%         name after data's name
%
%   gfout(data,fileName) writes data to the IEEE float-pointing SEGY file,
%         default: dt=0.001s
%
%   gfout(data,fileName,dt) writes data to the IEEE float-pointing SEGY file
%
%   gfout(data,fileName,dt,'ibm') writes data to the IBM float-pointing SEGY file
%
%   gfout(data,header,'hdr') writes data to the IEEE float-pointing
%         SEGY file with trace header,whose name after data'name
%
%   gfout(data,header,fileName,'hdr') writes data to the IEEE float-pointing
%         SEGY file with trace header
%
%   gfout(data,header,fileName,'ibm','hdr') writes data to the IBM float-pointing
%         SEGY file with trace header
%
%   gfout(data,...,'a',...) appends data to the SEGY file
%
%   Note:options 'a','hdr',and 'ibm' can be at any position for convenience
%         excepting the first position
%
%   See also gfin gfwritesu gfwritesegy gfwritedat gfwritegpr gfwritesegy
%   gfwritesegyhdr gfwritesegy2 and gfwritesegyhdr2
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

if isa(data,'gpuArray')
    data=gather(data);
end

io_type='w';
hdr_type='auto';
vars=varargin;
[isfind,vars]=gffindflag(vars,'a');
if isfind
    io_type='a';
end

[isfind,vars]=gffindflag(vars,'hdr');
if isfind
    hdr_type='hdr';
end

if strcmp(io_type,'w') && strcmp(hdr_type,'auto')
    gfwritesegy(data,vars);
elseif strcmp(io_type,'w') && strcmp(hdr_type,'hdr')
    gfwritesegyhdr(data,vars);
elseif strcmp(io_type,'a') && strcmp(hdr_type,'auto')
    gfwritesegy2(data,vars);
elseif strcmp(io_type,'a') && strcmp(hdr_type,'hdr')
    gfwritesegyhdr2(data,vars);
else
    nnerr.throw('there something wrong with parameters');
end

end

