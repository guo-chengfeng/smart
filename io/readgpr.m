function [data,hdr,hdrstr] = readgpr(fileName)

%   Author:  C.F. Guo
%   Date:    2016-8-31
%   Version: 1.0
data=[];
hdr=[];
hdrstr=[];
fileHeaderNum=1024;
fid=fopen(fileName);
fseek(fid,30,'bof');         %30-byte
antFre=fread(fid,1,'int16'); %32-byte

fseek(fid,22,'bof');         %54-byte
signal_position=fread(fid,1,'float32'); %从头文件读出信号位置 %58-byte

fseek(fid,54,'bof'); %112-byte
epsilon0=fread(fid,1,'float32');  %从头文件读出介电常数 %116-byte

fseek(fid,4,'bof'); %120-byte
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
hdr.ntr=TraceNum-cutcolumn; % number of trace
hdr.ns=sampointNum;         % number of sample per trace
hdr.tw=timeWindow;          % time window
hdr.sps=fs;                 % scans per second
hdr.eps=epsilon0;           % average dielectric constant
hdr.sp=signal_position;     % signal position
hdr.antfre=antFre;          %
try 
    data=single(fread(fid,[sampointNum,TraceNum-cutcolumn],'int16'));
catch ME
    if strcmp(ME.identifier, 'MATLAB:nomem')
        fseek(fid,fileHeaderNum+sampointNum*cutcolumn*2,'bof');
        data=zeros(sampointNum,TraceNum-cutcolumn,'single');
        for in=1:TraceNum-cutcolumn
            data(:,in)=single(fread(fid,[sampointNum,1],'int16'));
        end
    end
end    
fclose(fid);

hdrstr=char(strcat('GPR文件头参数'),...
    strcat('文件名:       ',fileName),...
    strcat('时窗（ns）:   ',num2str(timeWindow)),...
    strcat('取样道数:     ',num2str(TraceNum-cutcolumn)),...
    strcat('取样点数:     ',num2str(sampointNum)),...
    strcat('扫速(rad/s):  ',num2str(fs)),...
    strcat('平均介电常数: ',num2str(epsilon0)),...
    strcat('信号位置:     ',num2str(signal_position)));


