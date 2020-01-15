function [data,dataInfo] = loadMat(fileName)

%LOADMAT load data from simple binary file
%   header structure:
%   1-4 byte: data_type
%            0: short
%            1: int
%            2: float
%            3: double
%   5-8 byte: nx
%   9-12 byte: ns

fid=fopen(fileName,'rb');
if fid
    dataInfo=fread(fid,3,'int');

    switch dataInfo(1)
        case 0
            data=fread(fid,dataInfo(2)*dataInfo(3),'short');
        case 1
            data=fread(fid,dataInfo(2)*dataInfo(3),'int');
        case 2
            data=fread(fid,dataInfo(2)*dataInfo(3),'float');
        case 3
            data=fread(fid,dataInfo(2)*dataInfo(3),'double');
    end

    data=reshape(data,[dataInfo(3),dataInfo(2)]);
    fclose(fid);
end
end

