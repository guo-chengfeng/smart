function gfwritegpr(data,fileName,hdr)
%GFWRITEGPR writes data from GSSI Inc. SIR seriers *.dzt GPR file
%   gfwritegpr(data)
%   gfwritegpr(data,fileName)
%   gfwritegpr(data,fileName,hdr)
%       hdr: file header structure (only necessary parameter)
%       hdr.ntr        number of trace
%       hdr.ns         number of sample per trace
%       hdr.tw         time window
%       hdr.sps        scans per second
%       hdr.eps        average dielectric constant
%       hdr.sp         signal position
%
%   Author:  C.F. Guo
%   Date:    2016-8-31
%   Version: 1.0
%
[nz,nx]=size(data);

if nargin<3
    hdr.ntr=nx;        %number of trace
    hdr.ns=nz;         %number of sample per trace
    hdr.tw=nz*1e-1;   %time window
    hdr.sps=600;       %scans per second
    hdr.eps=3;          %average dielectric constant
    hdr.sp=20;         %signal position
end
if nargin<2
    dateStr=date();
    timeStr=clock();
    fileName=[inputname(1),'-',dateStr, '-',num2str(timeStr(4)),'-',...
        num2str(timeStr(5)),'.LTE'];
end
fid=fopen(fileName,'w+');
pad=zeros(512);
fwrite(fid,pad(1:2),'int16'); 
fwrite(fid,hdr.ns,'int16');   %5-6 bytes
fwrite(fid,pad(1:2),'int16');
fwrite(fid,hdr.sps,'float32'); %11-14 bytes
fwrite(fid,pad(1:4),'int16');
fwrite(fid,hdr.sp,'float32'); %23-26 bytes
fwrite(fid,hdr.tw,'float'); %27-30 bytes
fwrite(fid,pad(1:12),'int16');
fwrite(fid,hdr.eps,'float32');  %55-58 bytes
fwrite(fid,pad(1:483),'int16');

for i=1:nx
    fwrite(fid,data(:,i),'int16');
end
fclose(fid);

end

