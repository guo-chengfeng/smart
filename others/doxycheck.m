function newStr = doxycheck(tline)
%DOXYCHECK newStr = doxycheck(tline)
isfind = strfind(tline,'@');
if isfind
    word = '@';
    numTline = numel(tline);
    for in = isfind(1)+1:numTline
        if (tline(in) < 58 && tline(in) > 47) || (tline(in) < 91 && tline(in) > 64) ...
            || (tline(in) < 123 && tline(in) > 96) || (tline(in) == 95)
            word = [word,tline(in)]; 
        else
            word = ['<span class="doxygen">',word,'</span>'];
            break;
        end
    end
    
    newStr = [tline(1:isfind(1)-1),word,tline(in:end)];
else
    newStr = tline;
end
end

