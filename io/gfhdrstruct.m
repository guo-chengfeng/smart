function okfind=gfhdrstruct(keyword,verb)
%GFHDRSTRUCT  displays the segy trace header struct and search the items obtaining
%   keyword
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


if nargin<2
    verb=0;
end

if ~ischar(keyword)
    nnerr.throw('Key word must be string or chars');
end

BinaryFileHeader=struct();
TraceHeader=struct();
okfind=0;
keyword=lower(keyword);
% [1x3 cell]
BFH={{'int','taskid',3201,3204,'Job identification number'}, ...
    {'int','line',3205,3208,'Line number.For 3-D poststack data, this will typically contain the in-line number'}, ...
    {'int','volume',3209,3212,'Reel number'}, ...
    {'unsigned short','ntr',3213,3214,'Number of data traces per ensemble'}, ...
    {'unsigned short','axntr',3215,3216,'Number of auxiliary traces per ensemble'}, ...
    {'unsigned short','dt',3217,3218,'Sample interval in microseconds'}, ...
    {'unsigned short','dtdt',3219,3220,'Sample interval in microseconds of original field recording'}, ...
    {'unsigned short','ns',3221,3222,'Number of samples per data trace'}, ...
    {'unsigned short','nsns',3223,3224,'Integer Number of samples per data trace (original field recording)'}, ...
    {'unsigned short','format',3225,3226,'Flag Data sample format code: 1 = 32-bit IBM float; 2 = 32-bit integer; 3 = 16-bit integer; 4 = integer with gain code; 5 = IEEE float'}, ...
    {'unsigned short','cmpfold',3227,3228,'Integer Nominal CDP fold'}, ...
    {'unsigned short','selectid',3229,3230,'Flag Trace sorting code: 1 = as recorded (no sorting); 2 = CDP ensemble; 3 = single fold continuous profile; 4 = horizontally stacked'}, ...
    {'short', 'verticalid',3231,3232, 'Integer Number of vertically summed traces'}, ...
    {'short', 'startfrequency',3233,3234, 'Integer Sweep frequency at start (Hz)'}, ...
    {'short', 'endfrequency',3235,3236,'Integer Sweep frequency at end (Hz)'}, ...
    {'short', 'window',3237,3238, 'Integer Sweep length (milliseconds)'}, ...
    {'unsigned short','type',3239,3240,'Flag Sweep type: 1 = linear; 2 = parabolic; 3 = exponential; 4 = other'}, ...
    {'short', 'frequencytrace',3241,3242,'Integer Trace number of sweep channel'}, ...
    {'unsigned short', 'starttime',3243,3244,'Integer Sweep taper length at start (milliseconds)'}, ...
    {'unsigned short', 'endtime',3245,3246,'Integer Sweep taper length at end (milliseconds)'}, ...
    {'unsigned short','diptype',3247,3248, 'Flag Taper type: 1 = linear; 2 = cosine squared; 3 = other'}, ...
    {'unsigned short', 'cotrace',3249,3250, 'Flag Correlated data traces: 1 = yes, 2 = no'}, ...
    {'unsigned short', 'gain',3251,3252, 'Flag Binary gain recovered: 1 = yes, 2 = no'}, ...
    {'unsigned short', 'amplitude',3253,3254, 'Flag Amplitude recovery method: 1 = none; 2 = spherical divergence; 3 = AGC; 4 = none'}, ...
    {'unsigned short', 'measure',3255,3256 'Flag Measurement system: 1 = feet, 2 = meters'}, ...
    {'unsigned short', 'spolar',3257,3258,'Flag Impulse signal: 1 = negative amplitude means increased pressure or upward movement; 2 = positive amplitude means increased pressure or upward movement'}, ...
    {'unsigned short', 'polar', 3259,3260,'Flag Vibratory polarity code (seismic signal lags pilot trace by): 1 = 337.5 to 22.5 degrees, 2 = 22.5 to 67.5 degrees; 3 = 67.5 to 112.5 degrees, 4 = 112.5 to 157.5 degrees; 5 = 157.5 to 202.5 degrees, 6 = 202.5 to 247.5 degrees; 7 = 247.5 to 292.5 degrees, 8 = 292.5 to 337.5 degrees'}, ...
    {'short' 'empty',3260,3600,'Unassigned'}};

Description={char('Job identification number'), ...
    char('Line number.For 3-D poststack data, this will typically contain the in-line number'), ...
    char('Reel number'), ...
    char('Number of data traces per ensemble'), ...
    char('Number of auxiliary traces per ensemble'), ...
    char('Sample interval in microseconds '), ...
    char('Sample interval in microseconds of original field recording'), ...
    char('Number of samples per data trace'), ...
    char('Integer Number of samples per data trace (original field recording)'), ...
    char('Flag Data sample format code: ',...
    '1 = 32-bit IBM float; ',...
    '2 = 32-bit integer; ',...
    '3 = 16-bit integer; ',...
    '4 = integer with gain code; ',...
    '5 = IEEE float'), ...
    char('Integer Nominal CDP fold'), ...
    char('Flag Trace sorting code: ', ...
    '1 = as recorded (no sorting); ',...
    '2 = CDP ensemble; ',...
    '3 = single fold continuous profile; ',...
    '4 = horizontally stacked'), ...
    char('Integer Number of vertically summed traces'), ...
    char('Integer Sweep frequency at start (Hz)'), ...
    char('Integer Sweep frequency at end (Hz)'), ...
    char('Integer Sweep length (milliseconds)'), ...
    char('Flag Sweep type: ',...
    '1 = linear; ',...
    '2 = parabolic; ',...
    '3 = exponential; ',...
    '4 = other'), ...
    char('Integer Trace number of sweep channel'), ...
    char('Integer Sweep taper length at start (milliseconds)'), ...
    char('Integer Sweep taper length at end (milliseconds)'), ...
    char('Flag Taper type: ',...
    '1 = linear; ',...
    '2 = cosine squared; ',...
    '3 = other'), ...
    char('Flag Correlated data traces: ',...
    '1 = yes,',...
    '2 = no'), ...
    char('Flag Binary gain recovered: ','1 = yes,', '2 = no'), ...
    char('Flag Amplitude recovery method: ','1 = none;',' 2 = spherical divergence;',' 3 = AGC;',' 4 = none'), ...
    char('Flag Measurement system: ','1 = feet,',' 2 = meters'), ...
    char('Flag Impulse signal: ','1 = negative amplitude means increased pressure or upward movement;',...
    '2 = positive amplitude means increased pressure or upward movement'), ...
    char('Flag Vibratory polarity code (seismic signal lags pilot trace by): ', ...
    '1 = 337.5 to 22.5 degrees, 2 = 22.5 to 67.5 degrees; ',...
    '3 = 67.5 to 112.5 degrees, 4 = 112.5 to 157.5 degrees; ',...
    '5 = 157.5 to 202.5 degrees, 6 = 202.5 to 247.5 degrees; ',...
    '7 = 247.5 to 292.5 degrees, 8 = 292.5 to 337.5 degrees'), ...
    char('Unassigned')};
for i=1:28
    cellBFH=BFH{i};
    abbv=cellBFH{2};
    abbv=lower(abbv);
    if  ~isempty(strfind(abbv,keyword))
        okfind=1;
        BinaryFileHeader.codeFormat=cellBFH{1};
        BinaryFileHeader.abbreviation=cellBFH{2};
        BinaryFileHeader.byteStart=cellBFH{3};
        BinaryFileHeader.byteEnd=cellBFH{4};
        BinaryFileHeader.description=cellBFH{5};
        display(BinaryFileHeader);
        
        if verb
            display('Description:');
            display(Description{i});
        end
        continue;
    end
    
    des=cellBFH{5};
    des=lower(des);
    
    if  ~isempty(strfind(des,keyword))
        okfind=1;
        BinaryFileHeader.codeFormat=cellBFH{1};
        BinaryFileHeader.abbreviation=cellBFH{2};
        BinaryFileHeader.byteStart=cellBFH{3};
        BinaryFileHeader.byteEnd=cellBFH{4};
        BinaryFileHeader.description=cellBFH{5};
        display(BinaryFileHeader);
        
        if verb
            display('Description:');
            display(Description{i});
        end
        continue;
    end
end

TH={{'int','tracl', 001,004,'trace sequence number within line'},...
    {'int','tracr', 005,008,'trace sequence number within reel'},...
    {'int','fldr', 009,012,'field record number'},...
    {'int','tracf', 013,016,'trace number within field record'},...
    {'int','ep', 017,020,'energy source point','number'},...
    {'int','cdp', 021,024,'CDP ensemble number'},...
    {'int','cdpt',025,028,'trace number within CDP ensemble'},...
    {'short','trid',029,030,'trace identification code'},...
    {'short','nvs', 031,032,'number of vertically summed traces'},...
    {'short','nhs', 033,034,'number of horizontally summed traces'},...
    {'short','duse',035,036,'data use: 1 = production 2 = test'},...
    {'int','offset',037,040,'distance from source point to receiver group (negative if opposite to direction in which the line was shot)'},...
    {'int','gelev', 041,044,'receiver group elevation from sea level (above sea level is positive)'},...
    {'int','selev', 045,048,'source elevation from sea level (above sea level is positive)'},...
    {'int','sdepth',049,052,'source depth (positive)'},...
    {'int','gdel', 053,056,'datum elevation at receiver group'},...
    {'int','sdel', 057,060,'datum elevation at source'},...
    {'int','swdep', 061,064,'water depth at source'},...
    {'int','gwdep', 065,068,'water depth at receiver group'},...
    {'short','scalel', 069,070,'scale factor for previous 7 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) '},...
    {'short','scalco', 071,072,'scale factor for next 4 entries with value plus or minus 10 to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide)'},...
    {'int',' sx', 073,076,'X source coordinate'},...
    {'int',' sy', 077,080,'Y source coordinate'},...
    {'int',' gx', 081,084,'X group coordinate'},...
    {'int',' gy', 085,088,'Y group coordinate'},...
    {'short','counit',089,090,'coordinate units code: 1 = length (meters or feet) 2 = seconds of arc (in this case, the X values are longitude and the Y values are latitude, a positive value designates the number of seconds east of Greenwich or north of the equator'},...
    {'short','wevel',091,092,'weathering velocity'},...
    {'short','swevel', 093,094,'subweathering velocity'},...
    {'short','sut',095,096,'uphole time at source'},...
    {'short','gut',097,098,'uphole time at receiver group'},...
    {'short','sstat',099,100,'source static correction'},...
    {'short','gstat',101,102,'group static correction'},...
    {'short','tstat',103,104,'total static applied'},...
    {'short','laga',105,106,'lag time A, time in ms between end of 240-byte trace identification header and time break, positive if time break occurs after end of header, time break is defined as the initiation pulse which maybe recorded on an auxiliary trace or as otherwise specified by the recording system'},...
    {'short','lagb',107,108,'lag time B, time in ms between the time break and the initiation time of the energy source, may be positive or negative'},...
    {'short','delrt',109,110,'delay recording time, time in ms between initiation time of energy source and time when recording of data samples begins (for deep water work if recording does not start at zero time)'},...
    {'short','muts',111,112,'mute time--start'},...
    {'short','mute',113,114,'mute time--end'},...
    {'unsigned short','ns', 115,116,'number of samples in this trace'},...
    {'unsigned short','dt',117,118,'sample interval; in micro-seconds'},...
    {'short','gain',119,120,'gain type of field instruments code: 1 = fixed 2 = binary 3 = floating point 4 = optional use'},...
    {'short','igc', 121,122,'instrument gain constant'},...
    {'short','igi', 123,124,'instrument early or initial gain'},...
    {'short','corr',125,126,'correlated: 1 = no 2 = yes'},...
    {'short','sfs', 127,128,'sweep frequency at start'},...
    {'short','sfe', 129,130,'sweep frequency at end'},...
    {'short','slen',131,132,'sweep length in ms'},...
    {'short','styp',133,134,'sweep type code: 1 = linear 2 = cos-squared 3 = other'},...
    {'short','stas',135,136,'sweep trace length at start in ms'},...
    {'short','stae',137,138,'sweep trace length at end in ms'},...
    {'short','tatyp',139,140,'taper type: 1=linear, 2=cos^2, 3=other'},...
    {'short','afilf',141,142,'alias filter frequency if used'},...
    {'short','afils',143,144,'alias filter slope'},...
    {'short','nofilf', 145,146,'notch filter frequency if used'},...
    {'short','nofils', 147,148,'notch filter slope'},...
    {'short','lcf', 149,150,'low cut frequency if used'},...
    {'short','hcf', 151,152,'high cut frequncy if used'},...
    {'short','lcs', 153,154,'low cut slope'},...
    {'short','hcs', 155,156,'high cut slope'},...
    {'short','year',157,158,'year data recorded'},...
    {'short','day', 159,160,'day of year'},...
    {'short','hour',161,162,'hour of day (24 hour clock)'},...
    {'short','minute', 163,164,'minute of hour'},...
    {'short','sec', 165,166,'second of minute'},...
    {'short','timbas', 167,168,'time basis code: 1 = local 2 = GMT 3 = other'},...
    {'short','trwf',169,170,'trace weighting factor, defined as 1/2^N volts for the least sigificant bit'},...
    {'short','grnors', 171,172,'geophone group number of roll switch position one'},...
    {'short','grnofr', 173,174,'geophone group number of trace one within original field record'},...
    {'short','grnlof', 175,176,'geophone group number of last trace within original field record'},...
    {'short','gaps',177,178,'gap size (total number of groups dropped)'},...
    {'short','otrav',179,180,'overtravel taper code: 1 = down (or behind) 2 = up (or ahead)'},...
    {'short','empty',181,240, 'unassigned'}};

Description={char('trace sequence number within line'),...
    char('trace sequence number within reel'),...
    char('field record number'),...
    char('trace number within field record'),...
    char('energy source point','number'),...
    char('CDP ensemble number'),...
    char('trace number within CDP ensemble'),...
    char('trace identification code'),...
    char('number of vertically summed traces'),...
    char('number of horizontally summed traces'),...
    char('data use: 1 = production 2 = test'),...
    char('distance from source point to receiver group (negative if opposite to ',...
        'direction in which the line was shot)'),...
    char('receiver group elevation from sea level (above sea level is positive)'),...
    char('source elevation from sea level (above sea level is positive)'),...
    char('source depth (positive)'),...
    char('datum elevation at receiver group'),...
    char('datum elevation at source'),...
    char('water depth at source'),...
    char('water depth at receiver group'),...
    char('scale factor for previous 7 entries with value plus or minus 10 ',...
        'to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide) '),...
    char('scale factor for next 4 entries with value plus or minus 10 ', ...
        'to the power 0, 1, 2, 3, or 4 (if positive, multiply, if negative divide)'),...
    char('X source coordinate'),...
    char('Y source coordinate'),...
    char('X group coordinate'),...
    char('Y group coordinate'),...
    char('coordinate units code: ',...
        '1 = length (meters or feet) ',...
        '2 = seconds of arc ', ...
        '(in this case, the X values are longitude and the Y values are latitude, ',...
        'a positive value designates the number of seconds east of Greenwich or north of the equator'),...
    char('weathering velocity'),...
    char('subweathering velocity'),...
    char('uphole time at source'),...
    char('uphole time at receiver group'),...
    char('source static correction'),...
    char('group static correction'),...
    char('total static applied'),...
    char('lag time A, time in ms between end of 240-byte trace identification ',...'
        'header and time break, positive if time break occurs after end of header, ',...
        'time break is defined as the initiation pulse which maybe recorded on ',...
        'an auxiliary trace or as otherwise specified by the recording system'),...
    char('lag time B, time in ms between the time break and the initiation time ',...
        'of the energy source, may be positive or negative'),...
    char('delay recording time, time in ms between initiation time of energy source ',...
        'and time when recording of data samples begins (for deep water work if recording',...
        'does not start at zero time)'),...
    char('mute time--start'),...
    char('mute time--end'),...
    char('number of samples in this trace'),...
    char('sample interval; in micro-seconds'),...
    char('gain type of field instruments code: 1 = fixed',' 2 = binary',' 3 = floating point',' 4 = optional use'),...
    char('instrument gain constant'),...
    char('instrument early or initial gain'),...
    char('correlated:',' 1 = no',' 2 = yes'),...
    char('sweep frequency at start'),...
    char('sweep frequency at end'),...
    char('sweep length in ms'),...
    char('sweep type code:',' 1 = linear',' 2 = cos-squared',' 3 = other'),...
    char('sweep trace length at start in ms'),...
    char('sweep trace length at end in ms'),...
    char('taper type:',' 1=linear',' 2=cos^2',' 3=other'),...
    char('alias filter frequency if used'),...
    char('alias filter slope'),...
    char('notch filter frequency if used'),...
    char('notch filter slope'),...
    char('low cut frequency if used'),...
    char('high cut frequncy if used'),...
    char('low cut slope'),...
    char('high cut slope'),...
    char('year data recorded'),...
    char('day of year'),...
    char('hour of day (24 hour clock)'),...
    char('minute of hour'),...
    char('second of minute'),...
    char('time basis code: 1 = local 2 = GMT 3 = other'),...
    char('trace weighting factor, defined as 1/2^N volts for the least sigificant bit'),...
    char('geophone group number of roll switch position one'),...
    char('geophone group number of trace one within original field record'),...
    char('geophone group number of last trace within original field record'),...
    char('gap size (total number of groups dropped)'),...
    char('overtravel taper code: 1 = down (or behind) 2 = up (or ahead)'),...
    char('unassigned')};


for i=1:72
    cellTH=TH{i};
    abbv=cellTH{2};
    abbv=lower(abbv);
    if  ~isempty(strfind(abbv,keyword))
        okfind=1;
        TraceHeader.codeFormat=cellTH{1};
        TraceHeader.abbreviation=cellTH{2};
        TraceHeader.byteStart=cellTH{3};
        TraceHeader.byteEnd=cellTH{4};
        TraceHeader.description=cellTH{5};
        display(TraceHeader);
        
        if verb
            display('Description:');
            display(Description{i});
        end
        continue;
    end
    
    des=cellTH{5};
    des=lower(des);
    
    if  ~isempty(strfind(des,keyword))
        okfind=1;
        TraceHeader.codeFormat=cellTH{1};
        TraceHeader.abbreviation=cellTH{2};
        TraceHeader.byteStart=cellTH{3};
        TraceHeader.byteEnd=cellTH{4};
        TraceHeader.description=cellTH{5};
        display(TraceHeader);
        
        if verb
            display('Description:');
            display(Description{i});
        end
        continue;
    end
end


if ~okfind
    display('There is no infomation about the keyword')
end


end
