%GFEQDISP dispalys the elastic equations with displacement as
%   varibles for various media,e.g. isotropic, VTI or TTI media
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
syms U Ux Uy Uz real 
syms U2 Ux2 Uy2 Uz2 real 
syms C c11 c12 c13 c14 c15 c16 c22 c23 c24 c25 c26 c33 c34 c35 c36 c44 c45 c46 c55 c56 c66 real 

syms Ciso Cvti Ctti lamda mu  rho real

U=[Ux,Uy,Uz]';

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
  U2=1/rho*L*CC*L'*U;

  for in=1:3
     if U2(in)==0
         U(in)=0;
     end
  end
  
  U2=1/rho*L*CC*L'*U;
  Ux2=U2(1);
  Uy2=U2(2);
  Uz2=U2(3);