function  pHtmlToHtml(infileName,iRank,outfileName)
%PHTMLTOHTML converts pHtml to Html
%

if nargin < 2
    iRank = 1;
end
switch iRank
    case 0
        includepath = '';
    case 1
        includepath = '../';
    case 2
        includepath = '../../';
    case 3
        includepath = '../../../';
    case 4
        includepath = '../../../../';
    otherwise
        includepath = '';
end
if nargin < 1
    infileName = 'example.html';
end
if nargin < 3
    outfileName = [infileName,'.html'];
end
fidin = fopen(infileName,'r','native','utf-8');
fidout = fopen(outfileName,'w','native','utf-8');
fprintf(fidout,'%s\n','<!DOCTYPE HTML>');
fprintf(fidout,'%s\n','<html>');
fprintf(fidout,'%s\n','<head>');
fprintf(fidout,'%s\n','<meta charset="utf-8">');
fprintf(fidout,'%s\n','<meta name="viewport" content="width=device-width, initial-scale=1.0">');
fprintf(fidout,'%s\n','<meta http-equiv="X-UA-Compatible" content="IE=edge">');
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/bootstrap.min.css" rel="stylesheet" type="text/css">']);
fprintf(fidout,'%s\n','<meta http-equiv="Content-Script-Type" content="text/javascript">');
fprintf(fidout,'%s\n','<meta name="toctype" itemprop="pagetype" content="gs">');
fprintf(fidout,'%s\n','<meta name="infotype" itemprop="infotype" content="ex gs" />');
fprintf(fidout,'%s\n','<meta name="description" itemprop="description" content="Describes how to model a simple dynamic system using Simulink software" />');
fprintf(fidout,'%s\n',['<script type="text/javascript" src="',includepath,'includes/product/scripts/jquery/jquery-latest.js"></script>']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/site6.css?201602041954" rel="stylesheet" type="text/css">']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/site6_lg.css?201602041954" rel="stylesheet" media="screen and (min-width: 1200px)">']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/site6_md.css?201602041954" rel="stylesheet" media="screen and (min-width: 992px) and (max-width: 1199px)">']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/site6_sm+xs.css?201602041954" rel="stylesheet" media="screen and (max-width: 991px)">']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/site6_sm.css?201602041954" rel="stylesheet" media="screen and (min-width: 768px) and (max-width: 991px)">']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/site6_xs.css?201602041954" rel="stylesheet" media="screen and (max-width: 767px)">']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/site6_offcanvas.css?201602041954" rel="stylesheet" type="text/css">']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/shared/scripts/l10n.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/shared/scripts/docscripts.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/shared/scripts/f1help.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/product/scripts/docscripts.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/shared/scripts/mw.imageanimation.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/shared/scripts/jquery.highlight.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/product/scripts/underscore-min.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/product/scripts/suggest.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/product/scripts/jquery/jquery.mobile.custom.min.js"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/product/scripts/bootstrap.min.js" type="text/javascript"></script>']);
fprintf(fidout,'%s\n',['<script src="',includepath,'includes/product/scripts/global.js"></script>']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/doc_center.css" rel="stylesheet" type="text/css">']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/doc_center_installed.css" rel="stylesheet" type="text/css">']);
fprintf(fidout,'%s\n',['<link href="',includepath,'includes/product/css/doc_center_print.css" rel="stylesheet" type="text/css" media="print">']);
fprintf(fidout,'%s\n',['<script type="text/javascript" src="',includepath,'includes/ui/equationrenderer/release/MathRenderer.js"></script>']);
fprintf(fidout,'%s\n','<style type="text/css">');
fprintf(fidout,'%s\n','pre{ font-size:12px; }');
fprintf(fidout,'%s\n','pre{ margin:5px 0px 5px; }');
fprintf(fidout,'%s\n','pre.CCode{ padding:0px; border:1px solid #d3d3d3; background:#f7f7f7; }');
fprintf(fidout,'%s\n','span.processor {color:#EE7600 }');
fprintf(fidout,'%s\n','span.keyword { color:#0000FF }');
fprintf(fidout,'%s\n','span.comment { color:#228B22}');
fprintf(fidout,'%s\n','span.string { color:#FF00FF }');
fprintf(fidout,'%s\n','span.doxygen { color:#FF00AA }');
fprintf(fidout,'%s\n','span.char{ color:#FF1493}');
fprintf(fidout,'%s\n','span.usrkeyword { color:#0099FF }');
fprintf(fidout,'%s\n','span.blue {color: #0000FF} ');
fprintf(fidout,'%s\n','span.red {color: #FF0000} ');
fprintf(fidout,'%s\n','span.green {color: #00FF00} ');
fprintf(fidout,'%s\n','</style>');
fprintf(fidout,'\n');

%处理<head>，包括title语句和parent语言
in = 0;
isComments = 0;
while ~feof(fidin)
    tline=fgetl(fidin);
    if strfind(tline,'<!--')
        isComments = 1;
    end
    if strfind(tline,'-->')
        isComments = 0;
        continue;
    end
    if isComments == 0
        in = in + 1;
        content{in} = tline;
    end
end
nLine = numel(content);
headsp = 1;
headep = 1;
for in = 1:nLine
    if strfind(content{in},'<head>')
        headsp = in;
    end
    if strfind(content{in},'</head>')
        headep = in;
        break;
    end
end
titlestr = '';
for in = headsp+1 : headep-1
    if strfind(content{in},'<title>')
        tsp = strfind(content{in},'<title>');
        tep = strfind(content{in},'</title>');
        titlestr = content{in}(tsp+7:tep-1);
        fprintf(fidout,'%s\n',content{in});
    end
end
fprintf(fidout,'%s <!-- end head -->\n','</head>');
fprintf(fidout,'\n');
fprintf(fidout,'\n');
fprintf(fidout,'%s\n','<body id="responsive_offcanvas">');
fprintf(fidout,'%s\n','<div id="doc_header_spacer" class="header"></div>');
fprintf(fidout,'%s\n','<div class="sticky_header_container includes_subnav">');
fprintf(fidout,'%s\n','<div class="section_header level_3">');
fprintf(fidout,'%s\n','<div class="container-fluid">');
fprintf(fidout,'%s\n','<div class="row" id="mobile_search_row">');
fprintf(fidout,'%s\n','<div class="col-xs-12 col-sm-6 col-sm-push-6 col-md-5 col-md-push-7" id="mobile_search">');
fprintf(fidout,'%s\n','<div class="search_nested_content_container">');
fprintf(fidout,'%s\n','<form></form>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','<button class="btn icon-remove btn_search pull-right icon_32 visible-xs" data-toggle="collapse" href="#mobile_search" aria-expanded="false" aria-controls="mobile_search"></button></div>');
fprintf(fidout,'%s\n','<div class="col-sm-6 col-sm-pull-6 col-md-7 col-md-pull-5" id="section_header_title">');
fprintf(fidout,'%s\n','<div class="section_header_content">');
fprintf(fidout,'%s\n','<div class="section_header_title">');
fprintf(fidout,'%s\n','<h1>Note Books</h1>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div><!--END.CLASS row-->');
fprintf(fidout,'%s\n','</div><!--END.CLASS container-fluid-->');
fprintf(fidout,'%s\n','</div><!--END.CLASS section_header level_3-->');
fprintf(fidout,'%s\n','<div class="horizontal_nav">');
fprintf(fidout,'%s\n','<div class="horizontal_nav_container">');
fprintf(fidout,'%s\n','<div class="offcanvas_actuator active" data-toggle="offcanvas" data-target="#sidebar" id="nav_toggle">');
fprintf(fidout,'%s\n','<button type="button" class="btn"><span class="sr-only">Toggle navigation</span><span class="icon-menu icon_24"></span></button>');
fprintf(fidout,'%s\n','<span class="offcanvas_actuator_label"></span><span class="offcanvas_actuator_close"></span>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','<div class="offcanvas_horizontal_nav">');
fprintf(fidout,'%s\n','<div class="container-fluid">');
fprintf(fidout,'%s\n','<div class="row">');
fprintf(fidout,'%s\n','<div class="col-md-12 hidden-xs hidden-sm"></div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div><!--END.CLASS sticky_header_container-->');
fprintf(fidout,'%s\n','<div class="row-offcanvas row-offcanvas-left active">');
fprintf(fidout,'%s\n','<div class="sidebar-offcanvas" id="sidebar" role="navigation">');
fprintf(fidout,'%s\n','<nav class="offcanvas_nav" role="navigation">');
fprintf(fidout,'%s\n','<ul class="nav_breadcrumb">');
fprintf(fidout,'%s\n',['<li itemscope="" itemprop="breadcrumb"><a href="',includepath,'NoteBooks.html" itemprop="url"><span itemprop="title">全部笔记</span></a></li>']);
fprintf(fidout,'%s\n','</ul> ');

fprintf(fidout,'%s\n','<!-- 上级目录 -->');
fprintf(fidout,'%s\n','<ul class="nav_disambiguation">');
for in = headsp+1 : headep-1
    if strfind(content{in},'<parent>')
        str = content{in};
        ep = strfind(str,'<parent>');
        sp = strfind(str,'</parent>');
        fprintf(fidout,'%s\n',['<li class="product">',str(ep+8:sp-1),'</li>']);
    end
end
fprintf(fidout,'%s\n','</ul>');
fprintf(fidout,'%s\n','<ul class="nav_scrollspy nav">');
fprintf(fidout,'%s\n',['<li class="nav_scrollspy_function"><a href="#responsive_offcanvas">',titlestr,'</a></li>']);
fprintf(fidout,'%s\n','<li class="nav_scrollspy_title">On this page</li>');


im = 0;
ik = 0;

for in = headep+1:nLine
    if strfind(content{in},'<section')
        im = im + 1;
        sectionsp(im)  = in;
        titlesp = strfind(content{in},'"');
        sectionTilte{im} = content{in}(titlesp(1)+1:titlesp(2)-1);
    end
    if strfind(content{in},'</section>')
        ik = ik + 1;
        sectionep(ik)  = in;
    end
end

numSection  = numel(sectionTilte);
titleId = randname(numSection);
for in = 1:numSection
    fprintf(fidout,'%s\n',['<li><a href="#',titleId{in},'" class="intrnllnk">',sectionTilte{in},'</a></li>']);
end
fprintf(fidout,'%s\n','</ul>');

fprintf(fidout,'%s\n',['<script src="',includepath,'includes/product/scripts/offcanvas.js"></script>']);
fprintf(fidout,'%s\n','</div><!--END.CLASS sidebar-offcanvas-->');
fprintf(fidout,'%s\n','<div class="content_container" id="content_container">');
fprintf(fidout,'%s\n','<div class="container-fluid">');
fprintf(fidout,'%s\n','<div class="row">');
fprintf(fidout,'%s\n','<div class="col-xs-12">');

fprintf(fidout,'%s\n','<section id="doc_center_content" lang="en">');
fprintf(fidout,'%s\n','<div id="pgtype-topic">');
fprintf(fidout,'%s\n','<span id="bthii4g" class="anchor_target"></span>');
fprintf(fidout,'%s\n',['<h2 class="title r2016a" itemprop="title content" id="bthii4g">',titlestr,'</h2>']);
fprintf(fidout,'%s\n','<div itemprop="content">');
for in = 1:numSection
    codesp =  0;
    codeep =  0;
    iscode = 0;
    fprintf(fidout,'%s\n',['<span id="',titleId{in},'" class="anchor_target"></span>']);
    fprintf(fidout,'%s\n',['<h3 class="title" id="',titleId{in},'">',sectionTilte{in},'</h3>']);
    for ik = sectionsp(in)+1 : sectionep(in)-1
        if strfind(content{ik},'<code>')
            codesp = ik;
            iscode = 1;
        elseif strfind(content{ik},'</code>')
            codeep = ik;
            newCodeStr = CCodeToHtml2(content(codesp+1:codeep-1));
            nNewCodeStr = numel(newCodeStr);
            fprintf(fidout,'<tt>\n');
            fprintf(fidout,'%s\n',newCodeStr{1});
            for im = 2:nNewCodeStr-1
                if im-1 < 10
                    fprintf(fidout,'0%d. %s\n',im-1,newCodeStr{im});
                else
                    fprintf(fidout,'%d. %s\n',im-1,newCodeStr{im}); 
                end
            end
            fprintf(fidout,'%s\n',newCodeStr{nNewCodeStr});
            fprintf(fidout,'</tt>\n');
            iscode = 0;
        elseif iscode == 0
            fprintf(fidout,'%s\n',content{ik});
        end
    end
    
end
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</section>');

for in =  sectionep(end) + 1 : nLine
    if strfind(content{in},'<foot>')
        footsp = strfind(content{in},'<foot>');
        footep = strfind(content{in},'</foot>');
        footc =  content{in}(footsp+6:footep-1);
        break;
    end
end
for in =  sectionep(end) + 1 : nLine
    if strfind(content{in},'</footnav>')
        footnavp = strfind(content{in},'"');
        footnav =  content{in}(footnavp(1)+1:footnavp(2)-1);
        break;
    end
end

fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','<footer id="footer" class="bs-footer">');
fprintf(fidout,'%s\n','<div class="container-fluid">');
fprintf(fidout,'%s\n','<div class="footer">');
fprintf(fidout,'%s\n','<div class="row">');
fprintf(fidout,'%s\n','<div class="col-xs-12">');
fprintf(fidout,'%s\n',['<p class="copyright">',footc,'</p>']);
fprintf(fidout,'%s\n','<div id = "footernavs">');
fprintf(fidout,'%s\n',['<script> $("#footernavs").load("',footnav,'"); </script>']);
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</div>');
fprintf(fidout,'%s\n','</footer>');
fprintf(fidout,'%s\n','</div><!--close row-offcanvas-->');
fprintf(fidout,'%s\n','</body>');
fprintf(fidout,'%s\n','</html>');

fclose(fidin);
fclose(fidout);

end

