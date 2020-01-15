function data= gfreadat(path,nz,nx,startAt,endAt)
% GFREADAT reads data from a binary file
%
%   call:
%
%   data = gfreadat(fileName,nz,nx);
%   data = gfreadat(fileName,nz,nx,startAt);
%   data = gfreadat(fileName,nz,nx,startAt,endAt); 
%   
%   Note that, the size of the whole data is required parameter.
%   
%   See also gfin gfreadfile gfreadsu gfreadsegy gfreadgpr gfreadhdr 
%   gfreadsegyhdr and gfreadmala 
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
if nargin<5
    endAt=nx;
end
if nargin<4
    startAt=1;
end
fid=fopen(path,'rb');
fseek(fid,nz*4*(startAt-1),-1);
Width=endAt-startAt+1;
data=fread(fid,nz*Width,'float');
data=reshape(data,[nz Width]);
fclose(fid);
end

