function isfind = findKeyWord(keyWordList,keyWord)
numWord = numel(keyWordList);
isfind = 0;
for in = 1:numWord
    str = keyWordList{in};
    if strcmp(str,keyWord)
        isfind = 1;
        break;
    end
end