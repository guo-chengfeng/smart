function docdeclare(strName,strTime,strAuthor,strVersion,strReference,strSeeAlso)
%DOCDECLARE display the program infomation
%   docdeclare(strName,strTime,strAuthor,strVersion,strReference,strSeeAlso)
clc;
if nargin<6
    strSeeAlso='';
end
if nargin<5
    strReference='';
end
if nargin<4
    strVersion='V1.0';
end
if nargin<3
    strAuthor='郭成锋';
end
disp('%****************************************%');
disp(['% 名称：',strName]);
disp(['% 作者：',strAuthor]);
disp(['% 时间：',strTime]);
disp(['% 版本：',strVersion]);
if ~isempty(strReference)
disp(['% 参考文献: ',strReference]);
end
if ~isempty(strSeeAlso)
disp(['% See also: ',strSeeAlso]);
end
disp('%****************************************%');
disp('');

end

