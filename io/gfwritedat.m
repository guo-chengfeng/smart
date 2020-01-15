function  gfwritedat(L,path,option)
% GFWRITEDAT writes data to a pure binary file
%
%   call:
%
%   gfwritedat(data) writes data to a default file whose name after data
%   gfwritedat(data,fileName) writes data to a binary file
%   gfwritedat(data,fileName,'a') appends data to the binary file
%
%   I suggest to use SEGY files instead of pure binary files.
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11
%
% ------------------------------NOTE---------------------------------------
%
% This is a subroutine of Seismic Modeling and Research Toolkit (SMART),
% It is illegal for you to use this software tool (Seismic Modeling and
% Research Toolkit,SMART) for a purpose other than non-profit education
% or research UNLESS you are authorized by the Seismic Modeling Project.If
% you find any problems, please connect the Author(s): chf_guo@163.com
%
% by C.F. Guo, 2015
%
% Copyright(C) 2015 Elastic Wave Expolration Project (EWEP)
% China University of Petroleum(East China)
%
% ------------------------------END----------------------------------------
if isa(L,'gpuArray')
    L=gather(L);
end
[Nz,Nx]=size(L);
if nargin==1

    path=[inputname(1) '.dat'];
    fid=fopen(path,'w+');
    for i=1:Nx
        fwrite(fid,L(:,i),'float');
    end
    fclose(fid);
end

if nargin==2
    fid=fopen(path,'w+');
    for i=1:Nx
        fwrite(fid,L(:,i),'float');
    end
    fclose(fid);
end

if nargin==3 && option=='a'
    fid=fopen(path,'a+');
    for i=1:Nx
        fwrite(fid,L(:,i),'float');
    end
    fclose(fid);
end

end


