function [data,hdr,hdrstr] = gfreadgpr(fileName)
%GFREADGPR reads data from GSSI Inc. SIR seriers *.dzt GPR file
%   [data,hdr,hdrstr] = gfreadgpr(fileName)
%      data:   GPR data
%      hdr:    file header structure (only necessary parameter)
%      hdrstr: file header structure (text)
%   
%   See also gfin gfreadfile gfreadsu gfreadsegy gfreadat
%   gfreadhdr gfreadsegyhdr and gfreadmala 
%
%   Author:  C.F. Guo
%   Date:    2016-8-31
%   Version: 1.0
%

fileHeaderNum=1024; % bytes
fid=fopen(fileName);
fseek(fid,22,'bof');
signal_position=fread(fid,1,'float32'); %从头文件读出信号位置

fseek(fid,54,'bof');
epsilon0=fread(fid,1,'float32');  %从头文件读出介电常数

fseek(fid,4,'bof');
sampointNum=fread(fid,1,'int16'); %从头文件读出每道采样点数

fseek(fid,10,'bof');
fs=fread(fid,1,'float32');  %从头文件读出扫描速度

fseek(fid,26,'bof');
timeWindow=fread(fid,1,'float32'); %从头文件读出时窗（ns）记录时长

fseek(fid,0,'bof');
p1=ftell(fid);
fseek(fid,0,'eof');
p2=ftell(fid);
TraceNum=(p2-p1-fileHeaderNum)/(sampointNum*2);% 文件中总的道数

cutcolumn=0;% 前端截掉的道数   剪掉的道数多少对结果可能也会产生影响
fseek(fid,fileHeaderNum+sampointNum*cutcolumn*2,'bof');
%    if (TraceNum-cutcolumn>3000)
%        TraceNum=3000+cutcolumn;
%    end
data=fread(fid,[sampointNum,TraceNum-cutcolumn],'int16');
fclose(fid);

hdrstr=char(strcat('GPR文件头参数'),...
    strcat('文件名:       ',fileName),...
    strcat('时窗（ns）:   ',num2str(timeWindow)),...
    strcat('取样道数:     ',num2str(TraceNum-cutcolumn)),...
    strcat('取样点数:     ',num2str(sampointNum)),...
    strcat('扫速(rad/s):  ',num2str(fs)),...
    strcat('平均介电常数: ',num2str(epsilon0)),...
    strcat('信号位置:     ',num2str(signal_position)));

hdr.ntr=TraceNum-cutcolumn; % number of trace
hdr.ns=sampointNum;         % number of sample per trace
hdr.tw=timeWindow;          % time window
hdr.sps=fs;                 % scans per second
hdr.eps=epsilon0;           % average dielectric constant
hdr.sp=signal_position;      % signal position

end

