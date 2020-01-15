function hdr()
%HDR displays the segy trace header struct 
%
%     hdr.tracl:  int    /* 001-004 trace sequence number within line */';
%     hdr.tracr:  int    /* 005-008 trace sequence number within reel */';
%     hdr.fldr :  int    /* 009-012 field record number */';
%     hdr.tracf:  int    /* 013-016 trace number within field record */';
%     hdr.ep   :  int    /* 017-020 energy source point number */';
%     hdr.cdp  :  int    /* 021-024 CDP ensemble number */';
%     hdr.cdpt :  int    /* 025-028 trace number within CDP ensemble */';
%     hdr.trid :  short  /* 029-030 trace identification code, see the end of this struct definition for details*/';
%     hdr.nvs  :  short  /* 031-032 number of vertically summed traces */';
%     hdr.nhs  :  short  /* 033-034 number of horizontally summed traces */';
%     hdr.duse :  short  /* 035-036 data use: 1 = production 2 = test */';
%     hdr.offset: int    /* 037-040 distance from source point to receiver group (negative if opposite to direction in which the line was shot) */';
%     hdr.gelev:  int    /* 041-044 receiver group elevation from sea level (above sea level is positive) */';
%     hdr.selev:  int    /* 045-048 source elevation from sea level (above sea level is positive) */';
%     hdr.sdepth: int    /* 049-052 source depth (positive) */';
%     hdr.gdel :  int    /* 053-056 datum elevation at receiver group */';
%     hdr.sdel :  int    /* 057-060 datum elevation at source */';
%     hdr.swdep:  int    /* 061-064 water depth at source */';
%     hdr.gwdep:  int    /* 065-068 water depth at receiver group */';
%     hdr.scalel: short  /* 069-070 scale factor for previous 7 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */';
%     hdr.scalco: short  /* 071-072 scale factor for next 4 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) */';
%     hdr.sx   :  int    /* 073-076 X source coordinate */';
%     hdr.sy   :  int    /* 077-080 Y source coordinate */';
%     hdr.gx   :  int    /* 081-084 X group coordinate */';
%     hdr.gy   :  int    /* 085-088 Y group coordinate */';
%     hdr.counit: short  /* 089-090 coordinate units code: 1 = length (meters or feet) 2 = seconds of arc (in this case, the X values are longitude and the Y values are latitude, a positive value designates the number of seconds east of Greenwich or north of the equator */';
%     hdr.wevel:  short  /* 091-092 weathering velocity */';
%     hdr.swevel: short  /* 093-094 subweathering velocity */';
%     hdr.sut  :  short  /* 095-096 uphole time at source */';
%     hdr.gut  :  short  /* 097-098 uphole time at receiver group */';
%     hdr.sstat:  short  /* 099-100 source static correction */';
%     hdr.gstat:  short  /* 101-102 group static correction */';
%     hdr.tstat:  short  /* 103-104 total static applied */';
%     hdr.laga :  short  /* 105-106 lag time A, time in ms between end of 240-byte trace identification header and time break, positive if time break occurs after end of header, time break is defined as the initiation pulse which maybe recorded on an auxiliary trace or as otherwise specified by the recording system */';
%     hdr.lagb :  short  /* 107-108 lag time B, time in ms between the time break and the initiation time of the energy source, may be positive or negative */';
%     hdr.delrt:  short  /* 109-110 delay recording time, time in ms between initiation time of energy source and time when recording of data samples begins (for deep water work if recording does not start at zero time) */';
%     hdr.muts :  short  /* 111-112 mute time--start */';
%     hdr.mute :  short  /* 113-114 mute time--end */';
%     hdr.ns   :  unsigned short /* 115-116 number of samples in this trace */';
%     hdr.dt   :  unsigned short /* 117-118 sample interval; in micro-seconds */';
%     hdr.gain :  short  /* 119-120 gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 ---- N = optional use */';
%     hdr.igc  :  short  /* 121-122 instrument gain constant */';
%     hdr.igi  :  short  /* 123-124 instrument early or initial gain */';
%     hdr.corr :  short  /* 125-126 correlated: 1 = no 2 = yes */';
%     hdr.sfs  :  short  /* 127-128 sweep frequency at start */';
%     hdr.sfe  :  short  /* 129-130 sweep frequency at end */';
%     hdr.slen :  short  /* 131-132 sweep length in ms */';
%     hdr.styp :  short  /* 133-134 sweep type code: 1 = linear 2 = cos-squared 3 = other */';
%     hdr.stas :  short  /* 135-136 sweep trace length at start in ms */';
%     hdr.stae :  short  /* 137-138 sweep trace length at end in ms */';
%     hdr.tatyp:  short  /* 139-140 taper type: 1=linear, 2=cos^2, 3=other */';
%     hdr.afilf:  short  /* 141-142 alias filter frequency if used */';
%     hdr.afils:  short  /* 143-144 alias filter slope */';
%     hdr.nofilf: short  /* 145-146 notch filter frequency if used */';
%     hdr.nofils: short  /* 147-148 notch filter slope */';
%     hdr.lcf  :  short  /* 149-150 low cut frequency if used */';
%     hdr.hcf  :  short  /* 151-152 high cut frequncy if used */';
%     hdr.lcs  :  short  /* 153-154 low cut slope */';
%     hdr.hcs  :  short  /* 155-156 high cut slope */';
%     hdr.year :  short  /* 157-158 year data recorded */';
%     hdr.day  :  short  /* 159-160 day of year */';
%     hdr.hour :  short  /* 161-162 hour of day (24 hour clock) */';
%     hdr.minute: short  /* 163-164 minute of hour */';
%     hdr.sec  :  short  /* 165-166 second of minute */';
%     hdr.timbas: short  /* 167-168 time basis code: 1 = local 2 = GMT 3 = other */';
%     hdr.trwf :  short  /* 169-170 trace weighting factor, defined as 1/2^N volts for the least sigificant bit */';
%     hdr.grnors: short  /* 171-172 geophone group number of roll switch position one */';
%     hdr.grnofr: short  /* 173-174 geophone group number of trace one within original field record */';
%     hdr.grnlof: short  /* 175-176 geophone group number of last trace within original field record */';
%     hdr.gaps :  short  /* 177-178 gap size (total number of groups dropped) */';
%     hdr.otrav:  short  /* 179-180 overtravel taper code: 1 = down (or behind) 2 = up (or ahead) */';
%     hdr.blank:  blank  /* 181-240 blank space*/';
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


end

