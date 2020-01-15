function  codeToHtml(fileName)
if nargin < 1
    fileName = 'main.cpp';
end

keyWordList = {'double','int','inline','if','return','sizeof', 'void','const','try','new','float', 'for', 'class\n', 'else','asm','auto','bool','break','case','catch',...
    'public','char','size_t','using','false','while','delete','static','true','template','switch','this\n','struct',...
    'continue', 'decltype','alignof', 'default','do','alignas\n','dynamic_cast',...
    'enum', 'explicit', 'export', 'extern', 'final', 'char32_t', 'const_cast', 'constexpr',...
    'friend', 'goto', 'long', 'mutable', 'namespace','char16_t',...
    'noexcept', 'nullptr', 'operator', 'override', 'private', 'protected',...
    'register','reinterpret_cast','short','signed',...
    'static_assert','static_cast',...
    'thread_local','throw','typedef','typeid','typename','union',...
    'unsigned','virtual','volatile','wchar_t','int8_t',...
    'uint8_t','int16_t','uint16_t','int32_t','uint32_t','int64_t','uint64_t',...
    'int_least8_t','uint_least8_t','int_least16_t','uint_least16_t',...
    'int_least32_t','uint_least32_t','int_least64_t','uint_least64_t',...
    'int_fast8_t','uint_fast8_t','int_fast16_t','uint_fast16_t',...
    'int_fast32_t','uint_fast32_t','int_fast64_t','uint_fast64_t',...
    'intptr_t','uintptr_t','intmax_t','uintmax_t','wint_t','wchar_t',...
    'wctrans_t','wctype_t','time_t'};
usrKeyWordList = {'cout','std','cin','string','vector','list','array'};
fidin = fopen(fileName);
fidout = fopen([fileName,'.html'],'w');
fprintf(fidout,'%s\n','<!DOCTYPE HTML>');
fprintf(fidout,'%s\n','<html>');
fprintf(fidout,'%s\n','<head>');
fprintf(fidout,'%s\n','<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');
fprintf(fidout,'%s\n',['<title>',fileName,'</title>']);
fprintf(fidout,'%s\n','<style type="text/css">');
fprintf(fidout,'%s\n','pre{ font-size:12px; }');
fprintf(fidout,'%s\n','pre{ margin:0px 0px 20px; }');
fprintf(fidout,'%s\n','pre.CCode{ padding:0px; border:1px solid #d3d3d3; background:#f7f7f7; }');
fprintf(fidout,'%s\n','span.processor {color:#EE7600 }');
fprintf(fidout,'%s\n','span.keyword { color:#0000FF }');
fprintf(fidout,'%s\n','span.comment { color:#228B22}');
fprintf(fidout,'%s\n','span.string { color:#FF00FF }');
fprintf(fidout,'%s\n','span.char{ color:#FF1493}');
fprintf(fidout,'%s\n','span.usrkeyword { color:#B03060 }');
fprintf(fidout,'%s\n','</style>');
fprintf(fidout,'%s\n','</head>');
fprintf(fidout,'%s\n','<body>');
fprintf(fidout,'%s\n','<pre class="CCode">');
Jdoc = 0;
while ~feof(fidin)
    tline=fgetl(fidin);
    numTline = numel(tline);
    if numTline == 0
        fprintf(fidout,'\n');
        continue;
    end
    if strfind(tline,'/*')
        Jdoc = 1;
        fprintf(fidout,'<span class="comment">');
        fprintf(fidout,'%s',tline);
        fprintf(fidout,'</span>\n');
        if strfind(tline,'*/')
            Jdoc = 0;
        end
        continue;
    end
    if strfind(tline,'*/')
        fprintf(fidout,'<span class="comment">');
        fprintf(fidout,'%s',tline);
        fprintf(fidout,'</span>\n');
        Jdoc = 0;
        continue;
    end
    if Jdoc == 1
        fprintf(fidout,'<span class="comment">');
        fprintf(fidout,'%s',tline);
        fprintf(fidout,'</span>\n');
        continue;
    end
    cpDoc = strfind(tline,'//');
    if cpDoc
        if cpDoc(1) == 1
            fprintf(fidout,'<span class="comment">');
            fprintf(fidout,'%s',tline);
            fprintf(fidout,'</span>\n');
            continue;
        else
            str = maincontent(tline(1:cpDoc(1)-1),keyWordList,usrKeyWordList);
            fprintf(fidout,'%s',str);
            fprintf(fidout,'<span class="comment">');
            fprintf(fidout,'%s',tline(cpDoc(1):end));
            fprintf(fidout,'</span>\n');
            continue;
        end
    end
 
    str = maincontent(tline,keyWordList,usrKeyWordList);
    fprintf(fidout,'%s',str);
    fprintf(fidout,'\n');
end
fclose(fidin);
fclose(fidout);

end

