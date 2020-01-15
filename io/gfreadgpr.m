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
signal_position=fread(fid,1,'float32'); %��ͷ�ļ������ź�λ��

fseek(fid,54,'bof');
epsilon0=fread(fid,1,'float32');  %��ͷ�ļ�������糣��

fseek(fid,4,'bof');
sampointNum=fread(fid,1,'int16'); %��ͷ�ļ�����ÿ����������

fseek(fid,10,'bof');
fs=fread(fid,1,'float32');  %��ͷ�ļ�����ɨ���ٶ�

fseek(fid,26,'bof');
timeWindow=fread(fid,1,'float32'); %��ͷ�ļ�����ʱ����ns����¼ʱ��

fseek(fid,0,'bof');
p1=ftell(fid);
fseek(fid,0,'eof');
p2=ftell(fid);
TraceNum=(p2-p1-fileHeaderNum)/(sampointNum*2);% �ļ����ܵĵ���

cutcolumn=0;% ǰ�˽ص��ĵ���   �����ĵ������ٶԽ������Ҳ�����Ӱ��
fseek(fid,fileHeaderNum+sampointNum*cutcolumn*2,'bof');
%    if (TraceNum-cutcolumn>3000)
%        TraceNum=3000+cutcolumn;
%    end
data=fread(fid,[sampointNum,TraceNum-cutcolumn],'int16');
fclose(fid);

hdrstr=char(strcat('GPR�ļ�ͷ����'),...
    strcat('�ļ���:       ',fileName),...
    strcat('ʱ����ns��:   ',num2str(timeWindow)),...
    strcat('ȡ������:     ',num2str(TraceNum-cutcolumn)),...
    strcat('ȡ������:     ',num2str(sampointNum)),...
    strcat('ɨ��(rad/s):  ',num2str(fs)),...
    strcat('ƽ����糣��: ',num2str(epsilon0)),...
    strcat('�ź�λ��:     ',num2str(signal_position)));

hdr.ntr=TraceNum-cutcolumn; % number of trace
hdr.ns=sampointNum;         % number of sample per trace
hdr.tw=timeWindow;          % time window
hdr.sps=fs;                 % scans per second
hdr.eps=epsilon0;           % average dielectric constant
hdr.sp=signal_position;      % signal position

end

