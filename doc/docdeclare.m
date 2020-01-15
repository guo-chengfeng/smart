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
    strAuthor='���ɷ�';
end
disp('%****************************************%');
disp(['% ���ƣ�',strName]);
disp(['% ���ߣ�',strAuthor]);
disp(['% ʱ�䣺',strTime]);
disp(['% �汾��',strVersion]);
if ~isempty(strReference)
disp(['% �ο�����: ',strReference]);
end
if ~isempty(strSeeAlso)
disp(['% See also: ',strSeeAlso]);
end
disp('%****************************************%');
disp('');

end

