function  gfsolveChristoffel( stiffC,rhopar,kpar)
% GFSOLVECHRISTOFFEL solves the Christoffel equation and draw the phase velocity
%       
%   call:
%
%   gfsolveChristoffel(stiffMatrix,rho,k) solves the Christoffel equation. 
%
%   stiffMatrix is a 6-6 arrays. When k=0 (default), gfsolveChristoffel 
%   draws the P-wave velocity, k=1 calculates the SV-wave velocity, 
%   k=2 denotes the SH-wave.when the stiffMatrix is complex, there are 
%   no pure SV and SH waves
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2014/9/11 
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
% Copyright(C) 2015 Elastic Wave Expolration Project (EWEP)
% China University of Petroleum(East China)
% 
% ------------------------------END----------------------------------------
c11=stiffC(1,1);
c12=stiffC(1,2);
c13=stiffC(1,3);
c14=stiffC(1,4);
c15=stiffC(1,5);
c16=stiffC(1,6);
c22=stiffC(2,2);
c23=stiffC(2,3);
c24=stiffC(2,4);
c25=stiffC(2,5);
c26=stiffC(2,6);
c33=stiffC(3,3);
c34=stiffC(3,4);
c35=stiffC(3,5);
c36=stiffC(3,6);
c44=stiffC(4,4);
c45=stiffC(4,5);
c46=stiffC(4,6);
c55=stiffC(5,5);
c56=stiffC(5,6);
c66=stiffC(6,6);
if nargin==1
    rho=2500;
else
    rho=rhopar;
end
if nargin<3
    k=0; %k=0 rerpresents  P wave, k=1,2 represents SV and SH wave
        
else
    k=kpar;
end
thetaV=linspace(0,pi,50);
phiV=linspace(0,2.*pi,50);
[theta,phi]=meshgrid(thetaV,phiV);
Lx=sin(theta).*cos(phi);%theta is rotation angle; phi azimuth angle
Ly=sin(theta).*sin(phi);
Lz=cos(theta);
g11=Lx.*(Lx.*c11 + Ly.*c16 + Lz.*c15) + Lz.*(Lx.*c15 + Ly.*c56 + Lz.*c55) + Ly.*(Lx.*c16 + Ly.*c66 + Lz.*c56);
g12=Ly.*(Lx.*c12 + Ly.*c26 + Lz.*c25) + Lz.*(Lx.*c14 + Ly.*c46 + Lz.*c45) + Lx.*(Lx.*c16 + Ly.*c66 + Lz.*c56);
g13=Lz.*(Lx.*c13 + Ly.*c36 + Lz.*c35) + Ly.*(Lx.*c14 + Ly.*c46 + Lz.*c45) + Lx.*(Lx.*c15 + Ly.*c56 + Lz.*c55);
g22=Ly.*(Lx.*c26 + Ly.*c22 + Lz.*c24) + Lz.*(Ly.*c24 + Lx.*c46 + Lz.*c44) + Lx.*(Ly.*c26 + Lx.*c66 + Lz.*c46);
g23=Lz.*(Ly.*c23 + Lx.*c36 + Lz.*c34) + Ly.*(Ly.*c24 + Lx.*c46 + Lz.*c44) + Lx.*(Ly.*c25 + Lx.*c56 + Lz.*c45);
g33=Lz.*(Lx.*c35 + Ly.*c34 + Lz.*c33) + Ly.*(Lx.*c45 + Ly.*c44 + Lz.*c34) + Lx.*(Lx.*c55 + Ly.*c45 + Lz.*c35);

% Lx2=Lx.^2;
% Ly2=Ly.^2;
% Lz2=Lz.^2;
% Lyz=Ly.*Lz;
% Lzx=Lz.*Lx;
% Lxy=Lx.*Ly;

% g11=c11.*Lx2+c66.*Ly2+c55.*Lz2+2*c56.*Lyz+2*c15.*Lzx+2*c16.*Lxy;
% g12=c16.*Lx2+c26.*Ly2+c45.*Lz2+(c25+c46).*Lyz+(c14+c56).*Lzx+(c12+c66).*Lxy;
% g13=c15.*Lx2+c46.*Ly2+c35.*Lz2+(c45+c36).*Lyz+(c13+c55).*Lzx+(c14+c56).*Lxy;
% g22=c66.*Lx2+c22.*Ly2+c44.*Lz2+2*c24.*Lyz+2*c46.*Lzx+2*c26.*Lxy;
% g23=c56.*Lx2+c24.*Ly2+c34.*Lz2+(c23+c44).*Lyz+(c36+c45).*Lzx+(c25+c46).*Lxy;
% g33=c55.*Lx2+c44.*Ly2+c33.*Lz2+2*c34.*Lyz+2*c35.*Lzx+2*c45.*Lxy;

% G=[ g11 g12 g13;
%     g21 g22 g23;
%     g31 g32 g33;]
% det [  g11-phovp2       g12            g13
%          g21         g22-phovp2        g23
%          g31            g32         g33-phovp2 ]=0

a=-(g11+g22+g33);
b=g11.*g22+g11.*g33+g22.*g33-g12.^2-g13.^2-g23.^2;
c=g11.*g23.^2+g22.*g13.^2+g33.*g12.^2-g11.*g22.*g33-2.*g12.*g13.*g23;
d=-a.^2./3+b;
q=2.*(a./3).^3-a.*b./3+c;
beta=acos(-q./2./(-d./3).^1.5);% 0=<beta<=pi
beta=real(beta);
v=sqrt((2.*sqrt(-d./3).*cos(beta./3+k.*2.*pi./3)-a/3)./rho);


[X,Y,Z]=sph2cart(theta,phi,v);

mesh(X,Y,Z);
hidden off


end

