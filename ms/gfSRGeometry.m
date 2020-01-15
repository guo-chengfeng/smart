function srg = gfSRGeometry(trace,path)
% GLSRGEOMETRY creates source-receiver relation.
%


if nargin==1
    path=inputname(1);
end
n=max(size(trace));
shot=1;

% get the amount of sources
for i=1:n-1
    
    fldr1=trace(i).fldr;
    fldr2=trace(i+1).fldr;
    if fldr1~=fldr2
        shot=shot+1;
    end
end

R_start_cdp=zeros(shot,1);
R_end_cdp=zeros(shot,1);
S_position=zeros(shot,1);
Gather_start_position=zeros(shot,1);

% get the minmum receiver offset in terms of CDP number
% get the maxmum receiver offset in terms of CDP number
% get the starting point of each gather at the segy file
ishot=1;
R_start_cdp(ishot)=trace(ishot).cdp;
Gather_start_position(ishot)=1;
for i=1:n-1
    fldr1=trace(i).fldr;
    fldr2=trace(i+1).fldr;
    if fldr1~=fldr2
        
        R_end_cdp(ishot)=trace(i).cdp;
        ishot=ishot+1;
        R_start_cdp(ishot)=trace(i+1).cdp;
        Gather_start_position(ishot)=i+1;
    end
end
R_end_cdp(ishot)=trace(i+1).cdp;

% get the position of source in terms of CDP number
ishot=0;
Type_Gme=-1;
% Type_Gme=0  the Source located at the meddile of the gather
% Type_Gme=1  the Source located at the left of the gather
% Type_Gme=2  the Source located at the right of the gather
for i=2:R_end_cdp(1)
    offset1=trace(i-1).offset;
    offset2=trace(i).offset;
    offset3=trace(i+1).offset;
    if offset2<offset1 && offset2<offset3
        Type_Gme=0;
        break;
    end
end

if Type_Gme==-1
    for i=2:R_end_cdp(1)
        offset1=trace(i-1).offset;
        offset2=trace(i).offset;
        if offset1<offset2
            Type_Gme=1;
            break;
        end
    end
end

if Type_Gme==-1
    for i=2:R_end_cdp(1)
        offset1=trace(i-1).offset;
        offset2=trace(i).offset;
        if offset1>offset2
            Type_Gme=2;
            break;
        end
    end
end

if Type_Gme==0
    for i=2:n-1
        offset1=trace(i-1).offset;
        offset2=trace(i).offset;
        offset3=trace(i+1).offset;
        if offset2<offset1 && offset2<offset3
            ishot=ishot+1;
            S_position(ishot)=trace(i).cdp;
        end
    end
end

if Type_Gme==1
    ishot=1;
    S_position(ishot)=1;
    for i=2:nx
        offset1=trace(i-1).offset;
        offset2=trace(i).offset;
        if offset1>offset2
            ishot=ishot+1;
            S_position(ishot)=trace(i).cdp;
        end
    end
end


if Type_Gme==2
    ishot=0;
    for i=2:nx
        offset1=trace(i-1).offset;
        offset2=trace(i).offset;
        if offset1<offset2
            ishot=ishot+1;
            S_position(ishot)=trace(i-1).cdp;
        end
    end
end

%source-receiver geometry
shot_list=1:shot;
shot_position=S_position;
Amount_cdp=R_end_cdp-R_start_cdp+1;
srg=[shot_list',shot_position,R_start_cdp,R_end_cdp,Amount_cdp,Gather_start_position];

fid=fopen([path '.srg2'],'wt');
fprintf(fid,'#1:Shot_list    #2:Shot_position    #3:Start_cdp    #4:End_cdp    #5:Amount_cdp     #6:Gather_start_position\n');
for i=1:shot
    
    fprintf(fid,'%6d         %12d     %12d    %12d    %12d         %12d\n',srg(i,1),srg(i,2),srg(i,3),srg(i,4),srg(i,5),srg(i,6));
end
fclose(fid);

end

