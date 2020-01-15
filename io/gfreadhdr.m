function hdr = gfreadhdr(path,varargin)
% GFREADHDR reads trace header from the SEGY or SU file
%
%   call:
%
%   hdr = gfreadhdr(fileName) read whole data
%
%   hdr = gfreadhdr(fileName,startAt) read data from startAt trace
%       to the end of the file
%
%   hdr = gfreadhdr(fileName,startAt,endAt) read data from startAt trace
%       to endAt trace
%
%   If the input file is SU, a 'su' parameter is required. For example,
%   hdr = gfreadhdr(fileName,startAt,endAt,'su');
%   
%   See also gfin gfreadfile gfreadsu gfreadsegy gfreadgpr gfreadat
%   gfreadsegyhdr gfreadmala gfhdrstruct and gfhdrcreate 
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
data_type='segy';
var={};
if nargin>1
    if iscell(varargin{1})
        var=varargin{1};
    else
        var=varargin;
    end
    nv=numel(var);
    if nv>0
    for i=1:nv
        if strcmp(var{i},'su')
            data_type='su';
            var{i}=[];
        end
    end
    var=gfcopycell(var);
    end
end

if strcmp(data_type,'segy')
    
    fid=fopen(path,'rb','b');
    fseek(fid,3200,-1);
    hdrt=fread(fid,100,'int16');
    nz=hdrt(11);
    nnv=numel(var);
    fseek(fid,0,1);
    if nnv==2
        p_end=var{2};
        p_start=var{1};
    end
    if nnv==1
        pos=ftell(fid);
        p_end=(pos-3600)/(nz*4+240);
        p_start=var{1};
    end
    
    if nnv==0
        pos=ftell(fid);
        p_end=(pos-3600)/(nz*4+240);
        p_start=1;
    end
    fseek(fid,3600,-1);
    
elseif strcmp(data_type,'su')
    
    fid=fopen(path,'rb');
    hdrt=fread(fid,240,'int16');
    nz=hdrt(58);
    fseek(fid,0,1);
    nnv=numel(var);
    if nnv==2
        p_end=var{2};
        p_start=var{1};
    end
    if nnv==1
        pos=ftell(fid);
        p_end=pos/(nz*4+240);
        p_start=var{1};
    end
    
    if nnv==0
        pos=ftell(fid);
        p_end=pos/(nz*4+240);
        p_start=1;
    end
    fseek(fid,0,-1);
    
else
    nnerr.throw('ERROR: unrecognized file format');
end


nx=p_end-p_start+1;
fseek(fid,(p_start-1)*(nz+60)*4,0);

hdr=struct();

for i=1:nx
    
    hdr2=fread(fid,120,'int16');
    fseek(fid,-240,0);
    hdr4=fread(fid,60,'int');
    %     hdr(i).hdr2=hdr2;
    %     hdr(i).hdr4=hdr4;
    hdr(i).tracl=hdr4(1);   %/* 001-004 hdr sequence number within line */
    hdr(i).tracr=hdr4(2);   %/* 005-008 hdr sequence number within reel */
    hdr(i).fldr=hdr4(3);    %/* 009-012 field record number */
    hdr(i).tracf=hdr4(4);   %/* 013-016 hdr number within field record */
    hdr(i).ep=hdr4(5);      %/* 017-020 energy source point number */
    hdr(i).cdp=hdr4(6);     %/* 021-024 CDP ensemble number */
    hdr(i).cdpt=hdr4(7);    %/* 025-028 hdr number within CDP ensemble */
    hdr(i).trid=hdr2(15);  %/* 029-030 hdr identification code, see the end of this struct definition for details*/
    hdr(i).nvs=hdr2(16);   %/* 031-032 number of vertically summed hdrs */
    hdr(i).nhs=hdr2(17);   %/* 033-034 number of horizontally summed hdrs */
    hdr(i).duse=hdr2(18);  %/* 035-036 data use: 1 = production 2 = test */
    hdr(i).offset=hdr4(10);  %/* 037-040 distance from source point to receiver group (negative if opposite to direction in which the line was shot) */
    hdr(i).gelev=hdr4(11);   %/* 041-044 receiver group elevation from sea level (above sea level is positive) */
    hdr(i).selev=hdr4(12);   %/* 045-048 source elevation from sea level (above sea level is positive) */
    hdr(i).sdepth=hdr4(13);  %/* 049-052 source depth (positive) */
    hdr(i).gdel=hdr4(14);    %/* 053-056 datum elevation at receiver group */
    hdr(i).sdel=hdr4(15);    %/* 057-060 datum elevation at source */
    hdr(i).swdep=hdr4(16);   %/* 061-064 water depth at source */
    hdr(i).gwdep=hdr4(17);   %/* 065-068 water depth at receiver group */
    hdr(i).scalel=hdr2(35);%/* 069-070 scale factor for previous 7 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */
    hdr(i).scalco=hdr2(36);%/* 071-072 scale factor for next 4 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */
    hdr(i).sx=hdr4(19);      %/* 073-076 X source coordinate */
    hdr(i).sy=hdr4(20);      %/* 077-080 Y source coordinate */
    hdr(i).gx=hdr4(21);      %/* 081-084 X group coordinate */
    hdr(i).gy=hdr4(22);      %/* 085-088 Y group coordinate */
    hdr(i).counit=hdr2(45);%/* 089-090 coordinate units code: 1 = length (meters or feet) 2 = seconds of arc (in this case, the X values are longitude and the Y values are latitude, a positive value designates the number of seconds east of Greenwich or north of the equator */
    hdr(i).wevel=hdr2(46); % short wevel;    /* 091-092 weathering velocity */
    hdr(i).swevel=hdr2(47);% short swevel;   /* 093-094 subweathering velocity */
    hdr(i).sut=hdr2(48);   % short sut;      /* 095-096 uphole time at source */
    hdr(i).gut=hdr2(49);   % short gut;      /* 097-098 uphole time at receiver group */
    hdr(i).sstat=hdr2(50); % short sstat;    /* 099-100 source static correction */
    hdr(i).gstat=hdr2(51); % short gstat;    /* 101-102 group static correction */
    hdr(i).tstat=hdr2(52); % short tstat;    /* 103-104 total static applied */
    hdr(i).laga=hdr2(53);  % short laga;     /* 105-106 lag time A, time in ms between end of 240-byte hdr identification header and time break, positive if time break occurs after end of header, time break is defined as the initiation pulse which maybe recorded on an auxiliary hdr or as otherwise specified by the recording system */
    hdr(i).lagb=hdr2(54);  % short lagb;     /* 107-108 lag time B, time in ms between the time break and the initiation time of the energy source, may be positive or negative */
    hdr(i).delrt=hdr2(55); % short delrt;    /* 109-110 delay recording time, time in ms between initiation time of energy source and time when recording of data samples begins (for deep water work if recording does not start at zero time) */
    hdr(i).muts=hdr2(56);  % short muts;     /* 111-112 mute time--start */
    hdr(i).mute=hdr2(57);  % short mute;     /* 113-114 mute time--end */
    hdr(i).ns=hdr2(58);   % unsigned short ns;      /* 115-116 number of samples in this hdr */
    hdr(i).dt=hdr2(59);   % unsigned short dt;      /* 117-118 sample interval; in micro-seconds */      hdr(i).gain=fread(fid,1,'int16');% short gain;     /* 119-120 gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 ---- N = optional use */
    hdr(i).gain=hdr2(60); % short gain;     /* 119-120 gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 ---- N = optional use */
    hdr(i).igc=hdr2(61);   % short igc;      /* 121-122 instrument gain constant */
    hdr(i).igi=hdr2(62);   % short igi;      /* 123-124 instrument early or initial gain */
    hdr(i).corr=hdr2(63);  % short corr;     /* 125-126 correlated: 1 = no 2 = yes */
    hdr(i).sfs=hdr2(64);   % short sfs;      /* 127-128 sweep frequency at start */
    hdr(i).sfe=hdr2(65);   % short sfe;      /* 129-130 sweep frequency at end */
    hdr(i).slen=hdr2(66);  % short slen;     /* 131-132 sweep length in ms */
    hdr(i).styp=hdr2(67);  % short styp;     /* 133-134 sweep type code: 1 = linear 2 = cos-squared 3 = other */
    hdr(i).stas=hdr2(68);  % short stas;     /* 135-136 sweep hdr length at start in ms */
    hdr(i).stae=hdr2(69);  % short stae;     /* 137-138 sweep hdr length at end in ms */
    hdr(i).tatyp=hdr2(70); % short tatyp;    /* 139-140 taper type: 1=linear, 2=cos^2, 3=other */
    hdr(i).afilf=hdr2(71); % short afilf;    /* 141-142 alias filter frequency if used */
    hdr(i).afils=hdr2(72); % short afils;    /* 143-144 alias filter slope */
    hdr(i).nofilf=hdr2(73);% short nofilf;   /* 145-146 notch filter frequency if used */
    hdr(i).nofils=hdr2(74);% short nofils;   /* 147-148 notch filter slope */
    hdr(i).lcf=hdr2(75);   % short lcf;      /* 149-150 low cut frequency if used */
    hdr(i).hcf=hdr2(76);   % short hcf;      /* 151-152 high cut frequncy if used */
    hdr(i).lcs=hdr2(77);   % short lcs;      /* 153-154 low cut slope */
    hdr(i).hcs=hdr2(78);   % short hcs;      /* 155-156 high cut slope */
    hdr(i).year=hdr2(79);  % short year;     /* 157-158 year data recorded */
    hdr(i).day=hdr2(80);   % short day;      /* 159-160 day of year */
    hdr(i).hour=hdr2(81);  % short hour;     /* 161-162 hour of day (24 hour clock) */
    hdr(i).minute=hdr2(82);% short minute;   /* 163-164 minute of hour */
    hdr(i).sec=hdr2(83);   % short sec;      /* 165-166 second of minute */
    hdr(i).timbas=hdr2(84);% short timbas;   /* 167-168 time basis code: 1 = local 2 = GMT 3 = other */
    hdr(i).trwf=hdr2(85);  % short trwf;     /* 169-170 hdr weighting factor, defined as 1/2^N volts for the least sigificant bit */
    hdr(i).grnors=hdr2(86);% short grnors;   /* 171-172 geophone group number of roll switch position one */
    hdr(i).grnofr=hdr2(87);% short grnofr;   /* 173-174 geophone group number of hdr one within original field record */
    hdr(i).grnlof=hdr2(88);% short grnlof;   /* 175-176 geophone group number of last hdr within original field record */
    hdr(i).gaps=hdr2(89);  % short gaps;     /* 177-178 gap size (total number of groups dropped) */
    hdr(i).otrav=hdr2(90); % short otrav;    /* 179-180 overtravel taper code: 1 = down (or behind) 2 = up (or ahead) */
    hdr(i).blank=hdr2(91:120); %             /* 181-240 blank space
    fseek(fid,nz*4,0);
    
    
end
fclose(fid);

end
