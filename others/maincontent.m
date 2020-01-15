function newStr = maincontent(tline,keyWordList,usrKeyWordList)
pos1 = strfind(tline,'<span');
if ~isempty(pos1)
pos2 = strfind(tline,'</span>');
con = tline(pos1:pos2+5);
if pos2+7 > numel(tline)
    pos2 = pos2-1;
end
tline = [tline(1:pos1-1),'????????',tline(pos2+7:end)];
end





newStr = '';
if strfind(tline,'#')
    isfind = strfind(tline,'<');
    if isfind
        newStr = [tline(1:isfind(1)-1),'&lt',tline(isfind(1)+1:end)];
        tline = newStr;
    end
    isfind = strfind(tline,'>');
    if isfind
        newStr = [tline(1:isfind(1)-1),'&gt',tline(isfind(1)+1:end)];
        tline = newStr;
    end
    newStr = ['<span class="processor">',tline,'</span>'];
    return;
end

numTline = numel(tline);
word = '';

isString = 0;
isChar = 0;
isWord = 0;
for in = 1:numTline
    if strcmp(tline(in),'"')
        if isString == 1
            isString = 0;
            word = [word,tline(in)];
            newStr = [newStr,'<span class="string">',word,'</span>'];
            word = '';
            continue;
        else
            isString = 1;
            word = [word,tline(in)];
            continue;
        end
    elseif isString == 1
        word = [word,tline(in)];
        continue;
    end
    
    if tline(in) == ''''
        if isChar == 1
            isChar = 0;
            word = [word,tline(in)];
            newStr = [newStr,'<span class="char">',word,'</span>'];
            word = '';
            continue;
        else
            isChar = 1;
            word = [word,tline(in)];
            continue;
        end
    elseif isChar == 1
        word = [word,tline(in)];
        continue;
    end
    
    if (tline(in) < 58 && tline(in) > 47) || (tline(in) < 91 && tline(in) > 64) ...
            || (tline(in) < 123 && tline(in) > 96) || (tline(in) == 95)
        word = [word,tline(in)];
        isWord = 1;
        
        if in == numTline
            if findKeyWord(keyWordList,word);
                newStr = [newStr,'<span class="keyword">',word,'</span>'];
            elseif findKeyWord(usrKeyWordList,word);
                newStr = [newStr,'<span class="usrkeyword">',word,'</span>'];
            else
                newStr = [newStr,word];
            end
        end
        
        continue;
    else
        if isWord == 1
            if findKeyWord(keyWordList,word);
                newStr = [newStr,'<span class="keyword">',word,'</span>'];
            elseif findKeyWord(usrKeyWordList,word);
                newStr = [newStr,'<span class="usrkeyword">',word,'</span>'];
            else
                newStr = [newStr,word];
            end
            isWord = 0;
            word = '';
        end
        newStr = [newStr,tline(in)];
    end
end
if isChar == 1
    pos1 = strfind(tline,'''');
    newStr = [newStr, tline(pos1-1:end)];
end
pos1 = strfind(newStr,'????????');
if ~isempty(pos1)
if pos1+8 > numel(newStr)
    pos1 = pos1-1;
end
newStr = [newStr(1:pos1-1),con,newStr(pos1+8:end)];
end


end