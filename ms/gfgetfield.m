function F = gfgetfield(s,field)
%GFGETFIELD  Get structure field contents.
%
%     F = gfgetfield(S,'field') returns the contents of the specified
%     field.  

[nz,nx]=size(s);
if nz~=1
    F=gzeros(nz,1);
    for i=1:nz
        F(i)=getfield(s,{i},field);
    end
end
    
if nx~=1
    F=gzeros(1,nx);
    for i=1:nx
        F(i)=getfield(s,{i},field);
    end
end

end

