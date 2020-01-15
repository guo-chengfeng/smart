function  [header,hdr]= gfhdrcreate(nx)
%GFHDRCREATE  creates segy trace header struct
%
%   call:
%
%   [header,hdrStructure]= gfhdrcreate(nx) returns nx trace headers, all the 
%   member variables are set to zero. The hdrStructure is a self-doc which 
%   lists the member's abbreviation names.
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


hdr2=zeros(1,120,'int16');
hdr4=zeros(1,60,'int32');
header(nx)=struct();
for i=1:nx
    header(i).tracl=hdr4(1);    % int  tracl;     /* 001-004 trace sequence number within line */
    header(i).tracr=hdr4(2);    % int  tracr;     /* 005-008 trace sequence number within reel */
    header(i).fldr=hdr4(3);     % int  fldr;      /* 009-012 field record number */
    header(i).tracf=hdr4(4);    % int  tracf;     /* 013-016 trace number within field record */
    header(i).ep=hdr4(5);       % int  ep;        /* 017-020 energy source point number */
    header(i).cdp=hdr4(6);      % int  cdp;       /* 021-024 CDP ensemble number */
    header(i).cdpt=hdr4(7);     % int  cdpt;      /* 025-028 trace number within CDP ensemble */
    header(i).trid=hdr2(15);    % short trid;     /* 029-030 trace identification code, see the end of this struct definition for details*/
    header(i).nvs=hdr2(16);     % short nvs;      /* 031-032 number of vertically summed traces */
    header(i).nhs=hdr2(17);     % short nhs;      /* 033-034 number of horizontally summed traces */
    header(i).duse=hdr2(18);    % short duse;     /* 035-036 data use: 1 = production 2 = test */
    header(i).offset=hdr4(10);  % int   offset;   /* 037-040 distance from source point to receiver group (negative if opposite to direction in which the line was shot) */
    header(i).gelev=hdr4(11);   % int   gelev;    /* 041-044 receiver group elevation from sea level (above sea level is positive) */
    header(i).selev=hdr4(12);   % int   selev;    /* 045-048 source elevation from sea level (above sea level is positive) */
    header(i).sdepth=hdr4(13);  % int   sdepth ;  /* 049-052 source depth (positive) */
    header(i).gdel=hdr4(14);    % int   gdel;     /* 053-056 datum elevation at receiver group */
    header(i).sdel=hdr4(15);    % int   sdel;     /* 057-060 datum elevation at source */
    header(i).swdep=hdr4(16);   % int   swdep;    /* 061-064 water depth at source */
    header(i).gwdep=hdr4(17);   % int   gwdep;    /* 065-068 water depth at receiver group */
    header(i).scalel=hdr2(35);  % short scalel;   /* 069-070 scale factor for previous 7 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */
    header(i).scalco=hdr2(36);  % short scalco;   /* 071-072 scale factor for next 4 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */
    header(i).sx=hdr4(19);      % int   sx;       /* 073-076 X source coordinate */
    header(i).sy=hdr4(20);      % int   sy;       /* 077-080 Y source coordinate */
    header(i).gx=hdr4(21);      % int   gx;       /* 081-084 X group coordinate */
    header(i).gy=hdr4(22);      % int   gy;       /* 085-088 Y group coordinate */
    header(i).counit=hdr2(45);  % short counit;   /* 089-090 coordinate units code: 1 = length (meters or feet) 2 = seconds of arc (in this case, the X values are longitude and the Y values are latitude, a positive value designates the number of seconds east of Greenwich or north of the equator */
    header(i).wevel=hdr2(46);   % short wevel;    /* 091-092 weathering velocity */
    header(i).swevel=hdr2(47);  % short swevel;   /* 093-094 subweathering velocity */
    header(i).sut=hdr2(48);     % short sut;      /* 095-096 uphole time at source */
    header(i).gut=hdr2(49);     % short gut;      /* 097-098 uphole time at receiver group */
    header(i).sstat=hdr2(50);   % short sstat;    /* 099-100 source static correction */
    header(i).gstat=hdr2(51);   % short gstat;    /* 101-102 group static correction */
    header(i).tstat=hdr2(52);   % short tstat;    /* 103-104 total static applied */
    header(i).laga=hdr2(53);    % short laga;     /* 105-106 lag time A, time in ms between end of 240-byte trace identification header and time break, positive if time break occurs after end of header, time break is defined as the initiation pulse which maybe recorded on an auxiliary trace or as otherwise specified by the recording system */
    header(i).lagb=hdr2(54);    % short lagb;     /* 107-108 lag time B, time in ms between the time break and the initiation time of the energy source, may be positive or negative */
    header(i).delrt=hdr2(55);   % short delrt;    /* 109-110 delay recording time, time in ms between initiation time of energy source and time when recording of data samples begins (for deep water work if recording does not start at zero time) */
    header(i).muts=hdr2(56);    % short muts;     /* 111-112 mute time--start */
    header(i).mute=hdr2(57);    % short mute;     /* 113-114 mute time--end */
    header(i).ns=hdr2(58);      % unsigned short ns;      /* 115-116 number of samples in this trace */
    header(i).dt=hdr2(59);      % unsigned short dt;      /* 117-118 sample interval; in micro-seconds */      header(i).gain=fread(fid,1,'int16');% short gain;     /* 119-120 gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 ---- N = optional use */
    header(i).gain=hdr2(60);    % short gain;     /* 119-120 gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 ---- N = optional use */
    header(i).igc=hdr2(61);     % short igc;      /* 121-122 instrument gain constant */
    header(i).igi=hdr2(62);     % short igi;      /* 123-124 instrument early or initial gain */
    header(i).corr=hdr2(63);    % short corr;     /* 125-126 correlated: 1 = no 2 = yes */
    header(i).sfs=hdr2(64);     % short sfs;      /* 127-128 sweep frequency at start */
    header(i).sfe=hdr2(65);     % short sfe;      /* 129-130 sweep frequency at end */
    header(i).slen=hdr2(66);    % short slen;     /* 131-132 sweep length in ms */
    header(i).styp=hdr2(67);    % short styp;     /* 133-134 sweep type code: 1 = linear 2 = cos-squared 3 = other */
    header(i).stas=hdr2(68);    % short stas;     /* 135-136 sweep trace length at start in ms */
    header(i).stae=hdr2(69);    % short stae;     /* 137-138 sweep trace length at end in ms */
    header(i).tatyp=hdr2(70);   % short tatyp;    /* 139-140 taper type: 1=linear, 2=cos^2, 3=other */
    header(i).afilf=hdr2(71);   % short afilf;    /* 141-142 alias filter frequency if used */
    header(i).afils=hdr2(72);   % short afils;    /* 143-144 alias filter slope */
    header(i).nofilf=hdr2(73);  % short nofilf;   /* 145-146 notch filter frequency if used */
    header(i).nofils=hdr2(74);  % short nofils;   /* 147-148 notch filter slope */
    header(i).lcf=hdr2(75);     % short lcf;      /* 149-150 low cut frequency if used */
    header(i).hcf=hdr2(76);     % short hcf;      /* 151-152 high cut frequncy if used */
    header(i).lcs=hdr2(77);     % short lcs;      /* 153-154 low cut slope */
    header(i).hcs=hdr2(78);     % short hcs;      /* 155-156 high cut slope */
    header(i).year=hdr2(79);    % short year;     /* 157-158 year data recorded */
    header(i).day=hdr2(80);     % short day;      /* 159-160 day of year */
    header(i).hour=hdr2(81);    % short hour;     /* 161-162 hour of day (24 hour clock) */
    header(i).minute=hdr2(82);  % short minute;   /* 163-164 minute of hour */
    header(i).sec=hdr2(83);     % short sec;      /* 165-166 second of minute */
    header(i).timbas=hdr2(84);  % short timbas;   /* 167-168 time basis code: 1 = local 2 = GMT 3 = other */
    header(i).trwf=hdr2(85);    % short trwf;     /* 169-170 trace weighting factor, defined as 1/2^N volts for the least sigificant bit */
    header(i).grnors=hdr2(86);  % short grnors;   /* 171-172 geophone group number of roll switch position one */
    header(i).grnofr=hdr2(87);  % short grnofr;   /* 173-174 geophone group number of trace one within original field record */
    header(i).grnlof=hdr2(88);  % short grnlof;   /* 175-176 geophone group number of last trace within original field record */
    header(i).gaps=hdr2(89);    % short gaps;     /* 177-178 gap size (total number of groups dropped) */
    header(i).otrav=hdr2(90);   % short otrav;    /* 179-180 overtravel taper code: 1 = down (or behind) 2 = up (or ahead) */
    header(i).blank=hdr2(91:120); %              /* 181-240 blank space
end


    hdr.tracl=' int  tracl;     /* 001-004 trace sequence number within line */';
    hdr.tracr= ' int  tracr;     /* 005-008 trace sequence number within reel */';
    hdr.fldr=' int  fldr;      /* 009-012 field record number */';
    hdr.tracf=' int  tracf;     /* 013-016 trace number within field record */';
    hdr.ep=' int  ep;        /* 017-020 energy source point number */';
    hdr.cdp=' int  cdp;       /* 021-024 CDP ensemble number */';
    hdr.cdpt=' int  cdpt;      /* 025-028 trace number within CDP ensemble */';
    hdr.trid=' short trid;     /* 029-030 trace identification code, see the end of this struct definition for details*/';
    hdr.nvs=' short nvs;      /* 031-032 number of vertically summed traces */';
    hdr.nhs= ' short nhs;      /* 033-034 number of horizontally summed traces */';
    hdr.duse=' short duse;     /* 035-036 data use: 1 = production 2 = test */';
    hdr.offset=' int   offset;   /* 037-040 distance from source point to receiver group (negative if opposite to direction in which the line was shot) */';
    hdr.gelev=' int   gelev;    /* 041-044 receiver group elevation from sea level (above sea level is positive) */';
    hdr.selev=' int   selev;    /* 045-048 source elevation from sea level (above sea level is positive) */';
    hdr.sdepth=' int   sdepth ;  /* 049-052 source depth (positive) */';
    hdr.gdel= ' int   gdel;     /* 053-056 datum elevation at receiver group */';
    hdr.sdel= ' int   sdel;     /* 057-060 datum elevation at source */';
    hdr.swdep= ' int   swdep;    /* 061-064 water depth at source */';
    hdr.gwdep=' int   gwdep;    /* 065-068 water depth at receiver group */';
    hdr.scalel=' short scalel;   /* 069-070 scale factor for previous 7 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */';
    hdr.scalco=' short scalco;   /* 071-072 scale factor for next 4 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */';
    hdr.sx=' int   sx;       /* 073-076 X source coordinate */';
    hdr.sy= ' int   sy;       /* 077-080 Y source coordinate */';
    hdr.gx=' int   gx;       /* 081-084 X group coordinate */';
    hdr.gy=' int   gy;       /* 085-088 Y group coordinate */';
    hdr.counit=' short counit;   /* 089-090 coordinate units code: 1 = length (meters or feet) 2 = seconds of arc (in this case, the X values are longitude and the Y values are latitude, a positive value designates the number of seconds east of Greenwich or north of the equator */';
    hdr.wevel= ' short wevel;    /* 091-092 weathering velocity */';
    hdr.swevel= ' short swevel;   /* 093-094 subweathering velocity */';
    hdr.sut=' short sut;      /* 095-096 uphole time at source */';
    hdr.gut=' short gut;      /* 097-098 uphole time at receiver group */';
    hdr.sstat=' short sstat;    /* 099-100 source static correction */';
    hdr.gstat=' short gstat;    /* 101-102 group static correction */';
    hdr.tstat=' short tstat;    /* 103-104 total static applied */';
    hdr.laga=' short laga;     /* 105-106 lag time A, time in ms between end of 240-byte trace identification header and time break, positive if time break occurs after end of header, time break is defined as the initiation pulse which maybe recorded on an auxiliary trace or as otherwise specified by the recording system */';
    hdr.lagb=' short lagb;     /* 107-108 lag time B, time in ms between the time break and the initiation time of the energy source, may be positive or negative */';
    hdr.delrt=' short delrt;    /* 109-110 delay recording time, time in ms between initiation time of energy source and time when recording of data samples begins (for deep water work if recording does not start at zero time) */';
    hdr.muts=' short muts;     /* 111-112 mute time--start */';
    hdr.mute=' short mute;     /* 113-114 mute time--end */';
    hdr.ns=' unsigned short ns;      /* 115-116 number of samples in this trace */';
    hdr.dt=' unsigned short dt;      /* 117-118 sample interval; in micro-seconds */';     
    hdr.gain=' short gain;     /* 119-120 gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 ---- N = optional use */';
    hdr.igc=' short igc;      /* 121-122 instrument gain constant */';
    hdr.igi=' short igi;      /* 123-124 instrument early or initial gain */';
    hdr.corr=' short corr;     /* 125-126 correlated: 1 = no 2 = yes */';
    hdr.sfs=' short sfs;      /* 127-128 sweep frequency at start */';
    hdr.sfe=' short sfe;      /* 129-130 sweep frequency at end */';
    hdr.slen=' short slen;     /* 131-132 sweep length in ms */';
    hdr.styp=' short styp;     /* 133-134 sweep type code: 1 = linear 2 = cos-squared 3 = other */';
    hdr.stas=' short stas;     /* 135-136 sweep trace length at start in ms */';
    hdr.stae=' short stae;     /* 137-138 sweep trace length at end in ms */';
    hdr.tatyp=' short tatyp;    /* 139-140 taper type: 1=linear, 2=cos^2, 3=other */';
    hdr.afilf=' short afilf;    /* 141-142 alias filter frequency if used */';
    hdr.afils=' short afils;    /* 143-144 alias filter slope */';
    hdr.nofilf=' short nofilf;   /* 145-146 notch filter frequency if used */';
    hdr.nofils=' short nofils;   /* 147-148 notch filter slope */';
    hdr.lcf=' short lcf;      /* 149-150 low cut frequency if used */';
    hdr.hcf=' short hcf;      /* 151-152 high cut frequncy if used */';
    hdr.lcs=' short lcs;      /* 153-154 low cut slope */';
    hdr.hcs=' short hcs;      /* 155-156 high cut slope */';
    hdr.year=' short year;     /* 157-158 year data recorded */';
    hdr.day=' short day;      /* 159-160 day of year */';
    hdr.hour=' short hour;     /* 161-162 hour of day (24 hour clock) */';
    hdr.minute=' short minute;   /* 163-164 minute of hour */';
    hdr.sec=' short sec;      /* 165-166 second of minute */';
    hdr.timbas=' short timbas;   /* 167-168 time basis code: 1 = local 2 = GMT 3 = other */';
    hdr.trwf=' short trwf;     /* 169-170 trace weighting factor, defined as 1/2^N volts for the least sigificant bit */';
    hdr.grnors=' short grnors;   /* 171-172 geophone group number of roll switch position one */';
    hdr.grnofr=' short grnofr;   /* 173-174 geophone group number of trace one within original field record */';
    hdr.grnlof=' short grnlof;   /* 175-176 geophone group number of last trace within original field record */';
    hdr.gaps=' short gaps;     /* 177-178 gap size (total number of groups dropped) */';
    hdr.otrav=' short otrav;    /* 179-180 overtravel taper code: 1 = down (or behind) 2 = up (or ahead) */';
    hdr.blank=' blank space;    /* 181-240 blank space*/';
end

