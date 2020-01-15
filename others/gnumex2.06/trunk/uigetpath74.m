function outpath = uigetpath74(varargin)
% gets user selected directory 

    outpath = uigetdir('\','Choose directory');
    if isequal(outpath, 0)
        % user hit cancel, output empty instead of 0
        outpath = '';
    end

end