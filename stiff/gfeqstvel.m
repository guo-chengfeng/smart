%GFEQSTVEL dispalys the elastic equations with stress and particle
%   velocity as varibles for various media,e.g. isotropic, VTI or TTI media.
%
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11 
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
syms L lx ly lz real
syms V Vx Vy Vz real 
syms V1 Vx1 Vy1 Vz1 real 
syms Tao Txx Tyy Tzz Tyz Txz Txy real
syms Tao1 Txx1 Tyy1 Tzz1 Tyz1 Txz1 Txy1 real
syms C c11 c12 c13 c14 c15 c16 c22 c23 c24 c25 c26 c33 c34 c35 c36 c44 c45 c46 c55 c56 c66 real 

syms Ciso Cvti Ctti lamda mu  rho real

V=[Vx,Vy,Vz]';
Tao=[Txx,Tyy,Tzz,Tyz,Txz,Txy]';

% isotropic case c11=lamda+2mu  c12=lamda c44=mu
% c11=vp*vp*rho c12=vp*vp*rho-2*vs*vs*rho c44=vs*vs*rho
Ciso=[c11   c12   c12   0   0   0;
      c12   c11   c12   0   0   0;
      c12   c12   c11   0   0   0;
       0     0     0   c44  0   0;
       0     0     0    0  c44  0;
       0     0     0    0   0 c44];
 
% vti case c12=c11-2c44
Cvti=[c11   c12   c13   0   0   0;
      c12   c11   c13   0   0   0;
      c13   c13   c33   0   0   0;
       0     0     0   c44  0   0;
       0     0     0    0  c44  0;
       0     0     0    0   0 c66];
 
   % tti case 
Ctti=[c11   c12   c13   0  c15   0;
      c12   c11   c23   0  c25   0;
      c13   c23   c33   0  c35   0;
       0     0     0   c44  0   c46;
      c15   c25   c35   0  c55   0;
       0     0     0    0   0   c66];

  L=[ lx  0  0  0  lz ly;
      0  ly  0  lz 0  lx;
      0   0  lz ly lx 0];
    
  
  CC=Ciso;
  
  V1=1/rho*L*Tao;
  Tao1=CC*L'*V;

  
  for in=1:3
     if V1(in)==0
         V(in)=0;
     end
  end
  for in=1:6
      if Tao1(in)==0
          Tao(in)=0;
      end
  end
  V1=1/rho*L*Tao;
  Tao1=CC*L'*V;
  V1x=V1(1);
  V1y=V1(2);
  V1z=V1(3);
  Txx1=Tao1(1);
  Tyy1=Tao1(2);
  Tzz1=Tao1(3);
  Tyz1=Tao1(4);
  Txz1=Tao1(5);
  Txy1=Tao1(6);
