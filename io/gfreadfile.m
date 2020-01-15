function [data,hdr,hdrself] = gfreadfile(fileName,nz) 
%GFREADFILE read data from ground penetrating radar and seismic data file
%   ground penetrating radar data format includes *.lte, *LTE, *.rad, *dzt
%   seismic data format includes *.dat,*.su,*.segy
%
%   [data,hdr,hdrself] = gfreadfile(fileName)
%   [data,hdr,hdrself] = gfreadfile(fileName,nz) for binary data file
%   
%   See also gfin gfreadsu gfreadsegy gfreadgpr gfreadat gfreadhdr 
%   gfreadsegyhdr gfreadmala nad readzt
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2016/10/30

if nargin==1
    suffixStr=getfilesuffix(fileName);
    switch suffixStr
        case 'dat'
            [data,hdr]=loadMat(fileName);
            hdrself=[];
        case 'DZT'
            [data,hdr,~]=readzt(fileName);
            hdrself=[];
        case 'dzt'
            [data,hdr,~]=readzt(fileName);
            hdrself=[];
        case 'lte'   
            [data,hdr,hdrself]=readgpr(fileName);
        case 'LTE'
            [data,hdr,hdrself]=readgpr(fileName);
        case 'rad'
            [data,hdr,hdrself]=readgpr(fileName);
        case 'rd3'
            [data,hdr,hdrself]=readgpr(fileName);
        case 'rd7'
            [data,hdr,hdrself]=readgpr(fileName);
        case 'segy'
            hdr1=gfreadhdr(fileName,1,1);
            data=gfreadsegy(fileName);
            [nz,nx]=size(data);
            hdr.ns=nz;
            hdr.ntr=nx;
            hdrself=char(strcat('SEGY文件头参数'),...
                strcat('文件名:       ',fileName),...
                strcat('采样间隔(ms):   ',num2str(hdr1.dt*1000)),...
                strcat('取样道数:     ',num2str(nz)),...
                strcat('取样点数:     ',num2str(nx)));
        case 'su'
            hdr1=gfreadhdr(fileName,1,1,'su');
            data=gfreadsu(fileName);
            [nz,nx]=size(data);
            hdr.ns=nz;
            hdr.ntr=nx;
            hdrself=char(strcat('SU文件头参数'),...
                strcat('文件名:       ',fileName),...
                strcat('采样间隔:   ',num2str(hdr1.dt)),...
                strcat('取样道数:     ',num2str(nz)),...
                strcat('取样点数:     ',num2str(nx)));
        otherwise
            display('Unrecognized file format!');
    end
end
if nargin==2
    fid=fopen(path,'rb');
    fseek(fid,0,1);
    pos=ftell(fid);
    nx=floor(pos/(nz*4));
    data=fread(fid,nz*nx,'float');
    data=reshape(data,[nz nx]);
    hdr.ns=nz;
    hdr.ntr=nx;
    hdrself=char(strcat('二进制文件头参数'),...
        strcat('文件名:       ',fileName),...
        strcat('取样道数:     ',num2str(nz)),...
        strcat('取样点数:     ',num2str(nx)));
end  

end

