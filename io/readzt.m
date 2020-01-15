function [data,hdr] = readzt(fileName)
%READZT Summary of this function goes here
%   [data,hdr] = readzt(fileName)

% fileName='FILE____786.DZT';
fid=fopen(fileName);
fseek(fid,2,'bof');
%起始位置
hdr.startPoint=fread(fid,1,'short');
%每道采样点数
hdr.sampleNum=fread(fid,1,'short');
%数据格式
hdr.dataMode=fread(fid,1,'short');

hdr.zero=fread(fid,1,'short');

%每秒扫描数
fseek(fid,10,'bof');
hdr.scanNumSecond=fread(fid,1,'float');

%每米扫描数
fseek(fid,14,'bof');
hdr.scanNumMeter=fread(fid,1,'float');

%信号位置
fseek(fid,22,'bof');
hdr.position=fread(fid,1,'float');

%时间窗
hdr.timeWindow=fread(fid,1,'float');


fseek(fid,0,'eof');
p2=ftell(fid);
sampointNum=hdr.sampleNum;
TraceNum=(p2-1024)/(sampointNum*4);% 文件中总的道数

try
    fseek(fid,2048,'bof');
    data=single(fread(fid,[sampointNum,TraceNum],'int'));
catch ME
    if strcmp(ME.identifier, 'MATLAB:nomem')
        fseek(fid,1024,'bof');
        data=zeros(sampointNum,TraceNum,'single');
        for in=1:TraceNum
            data(:,in)=single(fread(fid,[sampointNum,1],'int'));
        end
    end
end

fclose(fid);
end

