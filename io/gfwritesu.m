function  gfwritesu(L,path,dt,option)
% GFWRITESU writes data to the little-endian SU file
%
%   call:
%
%   gfwritesu(data) writes data to a default file whose name after data
%       default: dt=0.001s
%   gfwritesu(data,fileName) writes data to the SU file, default: dt=0.001s
%
%   gfwritesu(data,fileName,dt) writes data to the SU file
%
%   gfwritesu(data,fileName,dt,'a') appends data to the SU file
%   
%   I suggest to use SEGY files instead of SU files for more use. So
%   SU I/O functions are simple.
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
zero1=zeros(1,57);
zero2=zeros(1,61);
if nargin==1
    dt=0.001;
    Dt=dt*1000*1000;
    path=[inputname(1) '.su'];
    fid=fopen(path,'w+');
    for i=1:Nx
         fwrite(fid,zero1,'int16');
         fwrite(fid,Nz,'ushort');
         fwrite(fid,Dt,'ushort');
         fwrite(fid,zero2,'int16');
         fwrite(fid,L(:,i),'float'); 
    end
    fclose(fid);
end



if nargin==2
    dt=0.001;
    Dt=dt*1000*1000;
    fid=fopen(path,'w+');
   
  
    for i=1:Nx
         fwrite(fid,zero1,'int16');
         fwrite(fid,Nz,'ushort');
         fwrite(fid,Dt,'ushort');
         fwrite(fid,zero2,'int16');
         fwrite(fid,L(:,i),'float'); 
    end
    fclose(fid);
end

if nargin==3
      Dt=dt*1000*1000;
      fid=fopen(path,'w+');
    for i=1:Nx
         fwrite(fid,zero1,'int16');
         fwrite(fid,Nz,'ushort');
         fwrite(fid,Dt,'ushort');
         fwrite(fid,zero2,'int16');
         fwrite(fid,L(:,i),'float'); 

    end
    fclose(fid);
end

if nargin==4 && option=='a'
    Dt=dt*1000*1000;
    fid=fopen(path,'a+');
    for i=1:Nx
         fwrite(fid,zero1,'int16');
         fwrite(fid,Nz,'ushort');
         fwrite(fid,Dt,'ushort');
         fwrite(fid,zero2,'int16');
         fwrite(fid,L(:,i),'float'); 

    end
    fclose(fid);
end



end


