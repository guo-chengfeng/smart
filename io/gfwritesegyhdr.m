function  gfwritesegyhdr(data,varargin)
% GFWRITESEGYHDR creates a SEGY file and writes data; discard existing contents.
%
%   call:
%
%   gfwritesegyhdr(data,header) writes data to a default file whose 
%   name after data
%
%   gfwritesegyhdr(data,header,fileName) writes data to the IEEE segy file
%
%   gfwritesegyhdr(data,header,fileName,'ibm') writes data to the IBM segy file
%
%   This function may be slower than GFWRITESEGY. Because the abbreviations 
%   of the member of the trace header strcut are not always uniform, this 
%   may make GFWRITESEGYHDR doesn't work correctly. So make sure that the 
%   trace header struct created CORRECTLY! You can use GFHDRCREATE to creats
%   trace header or use GFREADSEGYHDR or GFREADHDR to read a correct form.
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
fileName=[inputname(1) '.segy'];
if nargin>1
    if ~gfcellisempty(varargin)
        vars=gfextcell(varargin);
        [isfind,vars]=gffindflag(vars,'ibm');
        if isfind
            dat_type='ibm';
        end
        nvar=numel(vars);
        if nvar>1
            fileName=vars{2};
        end 
    end
end
header=vars{1};
if ~isstruct(header)
    nnerr.throw('Binary trace header is necessarily required');
end


Dt=header(1).dt;
bhr=zeros(1,8);
bhr3=zeros(1,187);
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

fid=fopen(fileName,'w+','b');
fwrite(fid,TextEBC');
fclose(fid);


fid=fopen(fileName,'ab','b');
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

for i=1:Nx
    fwrite(fid,header(i).tracl,'int');   %/* 001-004 trace sequence number within line */
    fwrite(fid,header(i).tracr,'int');    %/* 005-008 trace sequence number within reel */
    fwrite(fid,header(i).fldr,'int');    %/* 009-012 field record number */
    fwrite(fid,header(i).tracf,'int');   %/* 013-016 trace number within field record */
    fwrite(fid,header(i).ep,'int');     %/* 017-020 energy source point number */
    fwrite(fid,header(i).cdp,'int');      %/* 021-024 CDP ensemble number */
    fwrite(fid,header(i).cdpt,'int');    %/* 025-028 trace number within CDP ensemble */
    fwrite(fid,header(i).trid,'short');   %/* 029-030 trace identification code, see the end of this struct definition for details*/
    fwrite(fid,header(i).nvs,'short');   %/* 031-032 number of vertically summed traces */
    fwrite(fid,header(i).nhs,'short');   %/* 033-034 number of horizontally summed traces */
    fwrite(fid,header(i).duse,'short');   %/* 035-036 data use: 1 = production 2 = test */
    fwrite(fid,header(i).offset,'int');   %/* 037-040 distance from source point to receiver group (negative if opposite to direction in which the line was shot) */
    fwrite(fid,header(i).gelev,'int');    %/* 041-044 receiver group elevation from sea level (above sea level is positive) */
    fwrite(fid,header(i).selev,'int');    %/* 045-048 source elevation from sea level (above sea level is positive) */
    fwrite(fid,header(i).sdepth,'int');   %/* 049-052 source depth (positive) */
    fwrite(fid,header(i).gdel,'int');    %/* 053-056 datum elevation at receiver group */
    fwrite(fid,header(i).sdel,'int');     %/* 057-060 datum elevation at source */
    fwrite(fid,header(i).swdep,'int');    %/* 061-064 water depth at source */
    fwrite(fid,header(i).gwdep,'int');    %/* 065-068 water depth at receiver group */
    fwrite(fid,header(i).scalel,'short');%/* 069-070 scale factor for previous 7 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */
    fwrite(fid,header(i).scalco,'short');%/* 071-072 scale factor for next 4 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */
    fwrite(fid,header(i).sx,'int');      %/* 073-076 X source coordinate */
    fwrite(fid,header(i).sy,'int');     %/* 077-080 Y source coordinate */
    fwrite(fid,header(i).gx,'int');     %/* 081-084 X group coordinate */
    fwrite(fid,header(i).gy,'int');     %/* 085-088 Y group coordinate */
    fwrite(fid,header(i).counit,'short');%/* 089-090 coordinate units code: 1 = length (meters or feet) 2 = seconds of arc (in this case, the X values are longitude and the Y values are latitude, a positive value designates the number of seconds east of Greenwich or north of the equator */
    fwrite(fid,header(i).wevel,'short'); % short wevel;    /* 091-092 weathering velocity */
    fwrite(fid,header(i).swevel,'short');% short swevel;   /* 093-094 subweathering velocity */
    fwrite(fid,header(i).sut,'short');  % short sut;      /* 095-096 uphole time at source */
    fwrite(fid,header(i).gut,'short');  % short gut;      /* 097-098 uphole time at receiver group */
    fwrite(fid,header(i).sstat,'short'); % short sstat;    /* 099-100 source static correction */
    fwrite(fid,header(i).gstat,'short'); % short gstat;    /* 101-102 group static correction */
    fwrite(fid,header(i).tstat,'short'); % short tstat;    /* 103-104 total static applied */
    fwrite(fid,header(i).laga,'short');  % short laga;     /* 105-106 lag time A, time in ms between end of 240-byte trace identification header and time break, positive if time break occurs after end of header, time break is defined as the initiation pulse which maybe recorded on an auxiliary trace or as otherwise specified by the recording system */
    fwrite(fid,header(i).lagb,'short');  % short lagb;     /* 107-108 lag time B, time in ms between the time break and the initiation time of the energy source, may be positive or negative */
    fwrite(fid,header(i).delrt,'short'); % short delrt;    /* 109-110 delay recording time, time in ms between initiation time of energy source and time when recording of data samples begins (for deep water work if recording does not start at zero time) */
    fwrite(fid,header(i).muts,'short');  % short muts;     /* 111-112 mute time--start */
    fwrite(fid,header(i).mute,'short'); % short mute;     /* 113-114 mute time--end */
    fwrite(fid,header(i).ns,'ushort');   % unsigned short ns;      /* 115-116 number of samples in this trace */
    fwrite(fid,header(i).dt,'ushort');   % unsigned short dt;      /* 117-118 sample interval; in micro-seconds */      fwrite(fid,header(i).gain=fread(fid,1,'int16');% short gain;     /* 119-120 gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 ---- N = optional use */
    fwrite(fid,header(i).gain,'short'); % short gain;     /* 119-120 gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 ---- N = optional use */
    fwrite(fid,header(i).igc,'short');   % short igc;      /* 121-122 instrument gain constant */
    fwrite(fid,header(i).igi,'short');   % short igi;      /* 123-124 instrument early or initial gain */
    fwrite(fid,header(i).corr,'short');  % short corr;     /* 125-126 correlated: 1 = no 2 = yes */
    fwrite(fid,header(i).sfs,'short');   % short sfs;      /* 127-128 sweep frequency at start */
    fwrite(fid,header(i).sfe,'short');   % short sfe;      /* 129-130 sweep frequency at end */
    fwrite(fid,header(i).slen,'short');  % short slen;     /* 131-132 sweep length in ms */
    fwrite(fid,header(i).styp,'short');  % short styp;     /* 133-134 sweep type code: 1 = linear 2 = cos-squared 3 = other */
    fwrite(fid,header(i).stas,'short');  % short stas;     /* 135-136 sweep trace length at start in ms */
    fwrite(fid,header(i).stae,'short');  % short stae;     /* 137-138 sweep trace length at end in ms */
    fwrite(fid,header(i).tatyp,'short'); % short tatyp;    /* 139-140 taper type: 1=linear, 2=cos^2, 3=other */
    fwrite(fid,header(i).afilf,'short'); % short afilf;    /* 141-142 alias filter frequency if used */
    fwrite(fid,header(i).afils,'short'); % short afils;    /* 143-144 alias filter slope */
    fwrite(fid,header(i).nofilf,'short');% short nofilf;   /* 145-146 notch filter frequency if used */
    fwrite(fid,header(i).nofils,'short');% short nofils;   /* 147-148 notch filter slope */
    fwrite(fid,header(i).lcf,'short');  % short lcf;      /* 149-150 low cut frequency if used */
    fwrite(fid,header(i).hcf,'short');   % short hcf;      /* 151-152 high cut frequncy if used */
    fwrite(fid,header(i).lcs,'short');   % short lcs;      /* 153-154 low cut slope */
    fwrite(fid,header(i).hcs,'short');  % short hcs;      /* 155-156 high cut slope */
    fwrite(fid,header(i).year,'short');  % short year;     /* 157-158 year data recorded */
    fwrite(fid,header(i).day,'short');   % short day;      /* 159-160 day of year */
    fwrite(fid,header(i).hour,'short');  % short hour;     /* 161-162 hour of day (24 hour clock) */
    fwrite(fid,header(i).minute,'short');% short minute;   /* 163-164 minute of hour */
    fwrite(fid,header(i).sec,'short');  % short sec;      /* 165-166 second of minute */
    fwrite(fid,header(i).timbas,'short');% short timbas;   /* 167-168 time basis code: 1 = local 2 = GMT 3 = other */
    fwrite(fid,header(i).trwf,'short');  % short trwf;     /* 169-170 trace weighting factor, defined as 1/2^N volts for the least sigificant bit */
    fwrite(fid,header(i).grnors,'short');% short grnors;   /* 171-172 geophone group number of roll switch position one */
    fwrite(fid,header(i).grnofr,'short');% short grnofr;   /* 173-174 geophone group number of trace one within original field record */
    fwrite(fid,header(i).grnlof,'short');% short grnlof;   /* 175-176 geophone group number of last trace within original field record */
    fwrite(fid,header(i).gaps,'short'); % short gaps;     /* 177-178 gap size (total number of groups dropped) */
    fwrite(fid,header(i).otrav,'short'); % short otrav;    /* 179-180 overtravel taper code: 1 = down (or behind) 2 = up (or ahead) */
    fwrite(fid,header(i).blank,'short'); %                 /* 181-240 blank space
    fwrite(fid,data(:,i),'float');
    
end
fclose(fid);

end

