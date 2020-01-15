function data = gfreadsegy(path,p_start,p_end )
% GFREADSEGY reads data from the SEGY file
%
%   call:
%
%   data = gfreadsegy(fileName) reads whole data
%
%   data = gfreadsegy(fileName,startAt) reads data from startAt trace 
%       to the end of the file
%
%   data = gfreadsegy(fileName,startAt,endAt) reads data from startAt trace
%       to endAt trace
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

fid=fopen(path,'rb','b');
fseek(fid,3200,-1);
hdr=fread(fid,200,'int16');
nz=hdr(11);
format_code=hdr(13);
fseek(fid,0,1);
if nargin==2
    pos=ftell(fid);
    p_end=(pos-3600)/(nz*4+240);
end

if nargin==1
    pos=ftell(fid);
    p_end=(pos-3600)/(nz*4+240);
    p_start=1;
end
nx=p_end-p_start+1;
fseek(fid,3600,-1);
if p_end<p_start
    nnerr.throw('The end trace index is smaller than start trace');
end

if prod(size(p_start))>1 || prod(size(p_end))>1 || p_start<0 || p_end<0
    nnerr.throw('The trace index must be one positive number or a mtrix consist of one positive number ');
end

fseek(fid,(p_start-1)*(nz+60)*4,0);
datap=fread(fid,nx*(nz+60),'float');
datap=reshape(datap,[nz+60 nx]);
fclose(fid);
data=datap(61:nz+60,1:nx);
data=single(data);
if format_code==1
    pctype=computer();
    switch pctype
        case 'PCWIN'
            data=gfmxibm2ieeePCWIN(data);
        case 'PCWIN64'
            data=gfmxibm2ieeePCWIN64(data);  
        case 'GLNX86'
            data=gfmxibm2ieeeGLNX86(data);  
        case 'GLNXA64'
            data=gfmxibm2ieeeGLNXA64(data);  
        otherwise
            nnerr.throw('Error: The IBM-float pointing SEGY I/O function \ndoes not support this system architecture.');
    end

end

end



