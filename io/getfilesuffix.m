function suffixStr = getfilesuffix(fileName)
%GETFILESUFFIX get the suffix of file
%
%   suffixStr = getfilesuffix(fileName)
%

nc=numel(fileName);
for in=nc:-1:1
    char1=fileName(in);
    if strcmp(char1,'.')
        suffixStr=fileName(in+1:end);
        break;
    end
end

end

