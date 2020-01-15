function  saveMat(data,fileName,data_type)
%SAVEMAT save data as simple binary file
%   header structure:
%   1-4 byte: data_type
%            0: short
%            1: int
%            2: float
%            3: double
%   5-8 byte: nx
%   9-12 byte: ns

if nargin<3
    data_type=2;
end
fid=fopen(fileName,'wb');
if fid
    [nz,nx]=size(data);
    fwrite(fid,data_type,'int');
    fwrite(fid,nx,'int');
    fwrite(fid,nz,'int');
    switch data_type
        case 0
            for in=1:nx
                fwrite(fid,data(:,in),'short');
            end
        case 1
            for in=1:nx
                fwrite(fid,data(:,in),'int');
            end
        case 2
            for in=1:nx
                fwrite(fid,data(:,in),'float');
            end
        case 3
            for in=1:nx
                fwrite(fid,data(:,in),'double');
            end
    end
    fclose(fid);
end

