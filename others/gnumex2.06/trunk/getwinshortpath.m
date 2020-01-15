function shortPath = getwinshortpath(longPath)
% Returns the short path for a Windows long path
% 
% example:
%
% getwinshortpath('C:\Program Files') returns "C:\Progra~1"
%
% getwinshortpath makes use of ActiveX to query the operating system and
% requires that you be on a windows platform.
%

    fs = actxserver('Scripting.FileSystemObject');
    
    if ~exist(longPath,'dir')
        % this method results in an error if called on a
        % folder that doesn't exist, so create folder first
        mkdir(longPath);
    end
    
    shortPath = fs.GetFolder(longPath).ShortPath;
    
    fs.delete;

end