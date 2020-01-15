function [data,hdr,info]=gfreadmala(fileName)

data=0;
suffixStr=getfilesuffix(fileName);
nc=numel(suffixStr);

fileName3=[fileName(1:end-nc) 'rad'];
fileName1=[fileName(1:end-nc) 'rd3'];
fileName2=[fileName(1:end-nc) 'rd7'];

fid=fopen(fileName3);
if ~fid
    warning(['Not find parameter file ',fileName]);
    return
end
info=cell(1,38);
nline=1;
while 1
    tline = fgetl(fid);
    info{nline}=tline;
    if ~ischar(tline), break, end
    nline=nline+1;
%     disp(tline);
end
fclose(fid);
info{end}=[];
nsStr=info{1};
nsStr(1:8)=[];
ns=str2double(char(nsStr));
fid=fopen(fileName1,'rb');
if ~fid
    warning(['Not find data file ',fileName1, ', try to open ',fileName2]);
    
    fid=fopen(fileName2,'rb');
    if ~fid
        warning(['Not find data file ',fileName2, ', No input data file!']);
    else
        fseek(fid,0,1);
        pos=ftell(fid);
        ntr=(pos)/(ns*4);
        fseek(fid,0,-1);
        dat7=fread(fid,ntr*ns,'int');
        dat7=reshape(dat7,[ns,ntr]);
        data=dat7;
    end
else
    fseek(fid,0,1);
    pos=ftell(fid);
    ntr=(pos)/(ns*2);
    fseek(fid,0,-1);
    dat3=fread(fid,ntr*ns,'short');
    dat3=reshape(dat3,[ns,ntr]);
    data=dat3;
end

nsStr=info{19};
nsStr(1:11)=[];
tw=str2double(char(nsStr));
hdr.ntr=ntr; % number of trace
hdr.ns=ns;         % number of sample per trace
hdr.tw=tw;          % time window
hdr.sps=128;                 % scans per second
hdr.eps=3; 
tmp=info{4};
tmp(1:16)=[];
hdr.sp=str2double(tmp);      % signal position

end




