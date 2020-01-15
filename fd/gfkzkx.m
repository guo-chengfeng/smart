function [ kz,kx ] = gfkzkx(Nz,Nx,dz,dx)
%GFKZKX retruns the wavenumber domain operators
%   
%   call:
%
%   [ kz,kx ] = gfkzkx(Nz,Nx,dz,dx)
%
% ------------------------------NOTE---------------------------------------
%
% This a subroutine of Seismic Modeling and Research Toolkit (SMART),
% It is illegal for you to use this software tool (Seismic Modeling and 
% Research Toolkit,SMART) for a purpose other than non-profit education 
% or research UNLESS you are authorized by the Seismic Modeling Project.If 
% you find any problems, please connect the Author(s): chf_guo@163.com
% 
% by C.F. Guo, 2015
% 
% Copyright(C)2015 Anisotropic and Multicomponent (AN&MC) Sesimic Data 
% Processing Laboratory, China University of Petroleum(East China)
% 
% ------------------------------END----------------------------------------
Kxmax=pi/dx;
Kzmax=pi/dz;
dkx=Kxmax/(Nx/2);
dkz=Kzmax/(Nz/2);
kzl=[0,1:Nz/2-1,Nz/2,-(Nz-2)/2:-1]*dkz;
kxl=[0,1:Nx/2-1,Nx/2,-(Nx-2)/2:-1]*dkx;
kz=zeros(Nz,Nx);
kx=zeros(Nz,Nx);

for i=1:Nz
    kx(i,:)=kxl;
end
for j=1:Nx
    kz(:,j)=kzl;
end

end

