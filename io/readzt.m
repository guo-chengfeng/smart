function [data,hdr] = readzt(fileName)
%READZT Summary of this function goes here
%   [data,hdr] = readzt(fileName)

% fileName='FILE____786.DZT';
fid=fopen(fileName);
fseek(fid,2,'bof');
%��ʼλ��
hdr.startPoint=fread(fid,1,'short');
%ÿ����������
hdr.sampleNum=fread(fid,1,'short');
%���ݸ�ʽ
hdr.dataMode=fread(fid,1,'short');

hdr.zero=fread(fid,1,'short');

%ÿ��ɨ����
fseek(fid,10,'bof');
hdr.scanNumSecond=fread(fid,1,'float');

%ÿ��ɨ����
fseek(fid,14,'bof');
hdr.scanNumMeter=fread(fid,1,'float');

%�ź�λ��
fseek(fid,22,'bof');
hdr.position=fread(fid,1,'float');

%ʱ�䴰
hdr.timeWindow=fread(fid,1,'float');


fseek(fid,0,'eof');
p2=ftell(fid);
sampointNum=hdr.sampleNum;
TraceNum=(p2-1024)/(sampointNum*4);% �ļ����ܵĵ���

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

