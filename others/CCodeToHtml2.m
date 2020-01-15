function  newContent = CCodeToHtml2(Content)

keyWordList = {'import','interface','final','double','int','inline','if','return','sizeof', 'void','const','try','new','float', 'for', 'class\n', 'else','asm','auto','bool','break','case','catch',...
    'public','char','throws','size_t','using','false','while','delete','static','true','template','switch','this\n','struct','implements',...
    'continue', 'decltype','alignof', 'default','do','alignas\n','dynamic_cast',...
    'enum','end', 'explicit','package', 'export', 'extern', 'final', 'char32_t', 'const_cast', 'constexpr',...
    'friend', 'goto', 'long', 'mutable','super', 'namespace','char16_t',...
    'noexcept', 'nullptr', 'operator', 'override', 'private', 'protected',...
    'register','reinterpret_cast','short','signed','extends',...
    'static_assert','static_cast','boolean','byte','String','finally',...
    'thread_local','throw','typedef','typeid','typename','instanceof','union',...
    'unsigned','virtual','volatile','wchar_t','int8_t',...
    'uint8_t','int16_t','uint16_t','int32_t','uint32_t','int64_t','uint64_t',...
    'int_least8_t','uint_least8_t','int_least16_t','uint_least16_t',...
    'int_least32_t','uint_least32_t','int_least64_t','uint_least64_t',...
    'int_fast8_t','uint_fast8_t','int_fast16_t','uint_fast16_t',...
    'int_fast32_t','uint_fast32_t','int_fast64_t','uint_fast64_t',...
    'intptr_t','uintptr_t','intmax_t','uintmax_t','wint_t','wchar_t',...
    'wctrans_t','wctype_t','time_t'};
usrKeyWordList = {'std','cout','endl','cin','tic','toc','string','vector','list','array',...
    'bad_alloc','auto_ptr','cerr','complex','for_each','fstream','map',...
    'hash','hash_map','hash_set','ifstream','includes','ios_base','iostream',...
    'ofstream','queue','setw','shared_ptr','static_pointer_cast',...
    'stringstream','streambuf','tuple','valarray''wcerr','wcin','wcout','weak_ptr',...
    'wfilebuf','wfstream','wifstream','wiostream','wistream','wofstream','wregex'};

newContent{1} = '<pre class="CCode">';
Jdoc = 0;
nLine = numel(Content);
im  = 1;
for in = 1:nLine
    tline=Content{in};
    numTline = numel(tline);
    if numTline == 0
        im =  im+1;
        newContent{im} = tline;
        continue;
    end
    if strfind(tline,'/*')
        Jdoc = 1;
        tline = doxycheck(tline);
        str = ['<span class="comment">',tline,'</span>'];
        im =  im+1;
        newContent{im} = str;
        if strfind(tline,'*/')
            Jdoc = 0;
        end
        continue;
    end
    if strfind(tline,'*/')
        tline = doxycheck(tline);
        str = ['<span class="comment">',tline,'</span>'];
        im =  im+1;
        newContent{im} = str;
        Jdoc = 0;
        continue;
    end
    if Jdoc == 1
        tline = doxycheck(tline);
        str = ['<span class="comment">',tline,'</span>'];
        im =  im+1;
        newContent{im} = str;
        continue;
    end
    cpDoc = strfind(tline,'//');
    if cpDoc
        if cpDoc(1) == 1
            str = ['<span class="comment">',tline,'</span>'];
            im =  im+1;
            newContent{im} = str;
            continue;
        else
            str = maincontent(tline(1:cpDoc(1)-1),keyWordList,usrKeyWordList);
            str = [str,'<span class="comment">',tline(cpDoc(1):end),'</span>'];
            im =  im+1;
            newContent{im} = str;
            continue;
        end
    end
    
    str = maincontent(tline,keyWordList,usrKeyWordList);
    im =  im+1;
    newContent{im} = str;
end
im =  im+1;
newContent{im} = '</pre>';
end

