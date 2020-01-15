function shortpath = shortpath74(longpath)
% replacement for compiled shortpath74 to get short versions of windows
% paths
%
% shortpath74 is superceded by winshortpath.m for later Matlab versions)
%

    if isempty(longpath)
        % empty input, empty output
        shortpath = longpath;
    else
        try 
            % try querying windows using an activex server for the
            % short path
            shortPath = getwinshortpath(longPath);
        catch
            % try other methods
            if exist('shortpath74','file') ~= 3
                % cannot find shortpath74 mex file, try compiling it
                try
                    mex -output shortpath74 src/shortpath.c
                catch
                end
            end

            if exist('shortpath74','file') == 3
                % compilation of mex file succeeded
                % (so the next line is not an infinite recursion)
                shortpath = shortpath74(longpath);
            elseif exist('@RTW/transformPaths','file')
                % use RTW toolbox internal function to get same result
                if ~exist(longpath,'dir')
                    % limitation of RTW.transformPaths is you cannot call it
                    % on a folder that doesn't exist, so create folder first
                    mkdir(longpath)
                end
                shortpath = RTW.transformPaths(longpath);
            else
                warning('Failed to compile mex file. Try calling mex -setup')
                shortpath = longpath;
            end
            
        end
    end

end