function  gfwritesegy2(data,varargin)
% GFWRITESEGY2  appends data to a existing SEGY file, and if the given 
%   file don't exist, creates it and writes data
%
%   call:
%
%   gfwritesegy2(data) appends data to a default file whose name after data
%
%   gfwritesegy2(data,fileName) appends data to IEEE segy file with dt=0.001
%
%   gfwritesegy2(data,fileName,dt) appends data to the IEEE segy file
%
%   gfwritesegy2(data,fileName,dt,'ibm') appends data to the IBM segy file
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
a2e=[0, 1,  2,  3, 55, 45, 46, 47, 22,  5, 37, 11, 12, 13, 14, 15, ...
    16, 17, 18, 19, 60, 61, 50, 38, 24, 25, 63, 39, 28, 29, 30, 31, ...
    64, 79,127,123, 91,108, 80,125, 77, 93, 92, 78,107, 96, 75, 97, ...
    240,241,242,243,244,245,246,247,248,249,122, 94, 76,126,110,111, ...
    124,193,194,195,196,197,198,199,200,201,209,210,211,212,213,214, ...
    215,216,217,226,227,228,229,230,231,232,233, 74,224, 90, 95,109, ...
    121,129,130,131,132,133,134,135,136,137,145,146,147,148,149,150, ...
    151,152,153,162,163,164,165,166,167,168,169,192,106,208,161,  7, ...
    32, 33, 34, 35, 36, 21,  6, 23, 40, 41, 42, 43, 44,  9, 10, 27, ...
    48, 49, 26, 51, 52, 53, 54,  8, 56, 57, 58, 59,  4, 20, 62,225, ...
    65, 66, 67, 68, 69, 70, 71, 72, 73, 81, 82, 83, 84, 85, 86, 87, ...
    88, 89, 98, 99,100,101,102,103,104,105,112,113,114,115,116,117, ...
    118,119,120,128,138,139,140,141,142,143,144,154,155,156,157,158, ...
    159,160,170,171,172,173,174,175,176,177,178,179,180,181,182,183, ...
    184,185,186,187,188,189,190,191,202,203,204,205,206,207,218,219, ...
    220,221,222,223,234,235,236,237,238,239,250,251,252,253,254,255];

[Nz,Nx]=size(data);
dat_type='ieee';
dt=0.001;
fileName=[inputname(1) '.segy'];
if nargin>1
    if ~gfcellisempty(varargin)
        vars=gfextcell(varargin);
        [isfind,vars]=gffindflag(vars,'ibm');
        if isfind
            dat_type='ibm';
        end
        nvar=numel(vars);
        if nvar>0
            fileName=vars{1};
        end
        if nvar>1
            dt=vars{2};
        end
        
    end
end

Dt=dt*1000*1000;
TextHeader=zeros(40,80);

desp=cell(1,6);
desp{1}=' SELFDOC: THIS SEGY FILE WAS WRITEN BY GFSEGYWRITE';
desp{2}=' THE ORIGINAL CONTENTS MAYBE IS OVERWRITEN';
desp{3}=[' NUMBER OF PER TRACE:  ' num2str(Nz)];
desp{4}=[' SAMPLE INTERVAL:      ' num2str(Dt)];
desp{5}=[' CODEFORMAT:           ' dat_type 'FLOAT POINTING'];
desp{6}=[' TIME:                 ' date()];
for i=1:9
    TextHeader(i,1)='C';
    TextHeader(i,2)=' ';
    TextHeader(i,3)=num2str(i);
end
for ii=1:6
    despline=desp{ii};
cnx=size(despline,2);
for i=1:cnx
    TextHeader(ii,i+3)=despline(i);
end
end
for i=10:19
    TextHeader(i,1)='C';
    TextHeader(i,2)='1';
    TextHeader(i,3)=num2str(i-10);
end
for i=20:29
    TextHeader(i,1)='C';
    TextHeader(i,2)='2';
    TextHeader(i,3)=num2str(i-20);
end
for i=30:39
    TextHeader(i,1)='C';
    TextHeader(i,2)='3';
    TextHeader(i,3)=num2str(i-30);
end
TextHeader(40,1)='C';
TextHeader(40,2)='4';
TextHeader(40,3)='0';
TextHeader(TextHeader==0)=' ';
TextEBC=zeros(40,80);
for i=1:40
    for j=1:80
        TextEBC(i,j)=a2e(TextHeader(i,j)+1);
    end
end
if exist(fileName,'file')==0
    fid=fopen(fileName,'w+','b');
    fwrite(fid,TextEBC');
    bhr=zeros(1,8);
    bhr3=zeros(1,187);
    fwrite(fid,bhr,'int16');
    fwrite(fid,Dt,'ushort');
    fwrite(fid,Dt,'ushort');
    fwrite(fid,Nz,'ushort');
    fwrite(fid,Nz,'ushort');
    if strcmp(dat_type,'ibm')
        fwrite(fid,1,'int16');
    else
        fwrite(fid,5,'int16');
    end
    fwrite(fid,bhr3,'int16');
    fclose(fid);
end

if strcmp(dat_type,'ibm')
    if isa(data,'double')
        data=single(data);
    end
    pctype=computer();
    switch pctype
        case 'PCWIN'
            data=gfmxieee2ibmPCWIN(data);
        case 'PCWIN64'
            data=gfmxieee2ibmPCWIN64(data);  
        case 'GLNX86'
            data=gfmxieee2ibmGLNX86(data);  
        case 'GLNXA64'
            data=gfmxieee2ibmGLNXA64(data);  
        otherwise
            nnerr.throw('Error: The IBM-float pointing SEGY I/O function \ndoes not support this system architecture.');
    end
end

    fid=fopen(fileName,'ab','b');
    % tracl    %/* 001-004 trace sequence number within line,increase progressively */
    % tracr    %/* 005-008 trace sequence number within reel */
    % FFID     %/* 009-012 field record number(shot number)*/
    trid=1;    %/* 029-030 trace identification code(default:1), see the end of this struct definition for details*/
    zero1=zeros(1,4);
    zero2=zeros(1,42);
    zero3=zeros(1,61);
    for i=1:Nx
        tracl=i;
        tracr=i;
        FFID=1;
        fwrite(fid,tracl,'int');
        fwrite(fid,tracr,'int');
        fwrite(fid,FFID,'int');
        fwrite(fid,zero1,'int');
        fwrite(fid,trid,'int16');
        fwrite(fid,zero2,'int16');
        fwrite(fid,Nz,'int16');
        fwrite(fid,Dt,'int16');
        fwrite(fid,zero3,'int16');
        fwrite(fid,data(:,i),'float');
       
    end
    fclose(fid);
    
end

