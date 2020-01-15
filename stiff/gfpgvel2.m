function [pangle,pvelp,pvels,ganglep,gvelp,gangles,gvels] = gfpgvel2(vp,vs,epsilon,delta,dip,verb)
%GFPGVEL2 calculate the phase velocity and group velocity and  angle
%   
%   [pangle,pvelp,pvels,ganglep,gvelp,gangles,gvels] = gfpgvel2(vp,vs,epsilon,delta,verb)
%
%   gfpgvel2 is more stable than gfpgvel.The algorithm for group angle is
%   taken form "Practical vti approximations: a systematic anatomy"  
%
%   input parameters:
%   vp -- velocity of P wave
%   vs -- velocity of S wave
%   epsilon -- Thomsen anisotropy parameter relative to the ration of
%        horizontal velocity to vertical velocity
%   delta -- Thomsen anisotropy parameter relative to small-offset NMO
%       velocity 
%   dip -- the dip angle in degree of the symmetery axis (ha! it's
%       pseudo-tilted, I rotate the coordinate axis instead of the symmetery
%       axis)
%   verb -- plot the velocities or not 
%   
%   output parameters
%   pangle -- phase angle
%   pvelp -- phase velocity of P wave
%   pvels -- phase velocity of S wave
%   ganglep -- group angle for P wave
%   gvelp -- group velocity for P wave
%   gangles -- group angle for S wave
%   gvels -- group velocity for S wave
% 
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/11/6
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

if nargin<6
    verb=0;
end
if nargin<6
    dip=0;
end
if nargin<4
    delta=0.1;
end

 if nargin<3
    epsilon=0.15;
end  
 if nargin<2
    vs=1500;
 end  
 if nargin<1
    vp=2500;
 end  

 if vs>vp || vs==vp 
     nnerr.throw('Vp must be greater than Vs');
 end

theta=-0.5*pi:0.0125*pi:2.5*pi+0.1;
theta1=theta(41:201);
vp0=vp;
vs0=vs;

% parameters

f=1-(vs0/vp0)*(vs0/vp0);

%exact p-wave  sulotion
evp=vp0^2*(1+epsilon*sin(theta).^2-f/2+0.5*f*sqrt((1+2*epsilon*sin(theta).^2/f).^2-8*(epsilon-delta)*sin(theta).^2.*cos(theta).^2/f));
evp=sqrt(evp);
ispositive2(evp);
isreal2(evp);
evp1=evp(41:201);

%exact s-wave sulotion
evs=vp0^2*(1+epsilon*sin(theta).^2-f/2-0.5*f*sqrt((1+2*epsilon*sin(theta).^2/f).^2-8*(epsilon-delta)*sin(theta).^2.*cos(theta).^2/f));
ispositive2(evs);
isreal2(evs);
evs=sqrt(evs);
evs1=evs(41:201);
 
%group angle  of exact p-wave
 vp=evp;
 tphi=(1./vp.*gfLx1(vp,0.0125*pi,1));
 phi=atan(tphi)+theta;
 ephi1=phi(41:201);

 
 %group angle  of exact s-wave
 vs=evs;
 tphi=(1./vs.*gfLx1(vs,0.0125*pi,1));
 phis=atan(tphi)+theta;
 phis(isnan(phis))=0.5*pi;
 ephis1=phis(41:201);

 %group velocity of exact p-wave 
 evpg=sqrt(evp.^2+gfLx1(evp,0.0125*pi,1).^2);
 evpg1=evpg(41:201);
  ispositive2(evpg);
  isreal2(evpg);
  %group velocity of exact s-wave 
 evsg=sqrt(evs.^2+gfLx1(evs,0.0125*pi,1).^2);
 ispositive2(evsg);
  isreal2(evsg);
 evsg1=evsg(41:201);
 if verb==1
% phase velocity  
figure(1)
polar2(dip,theta1,evp1,[0,vp0*1.5,0,2*pi],'r')
hold on
polar2(dip,theta1,evs1,[0,vp0*1.5,0,2*pi]);
title('Phase velocity');
view(90+dip,90)

%group velocity

figure(2)
polar2(dip,ephi1,evpg1,[0,vp0*1.5,0,2*pi],'r');
hold on
polar2(dip,ephis1,evsg1,[0,vp0*1.5,0,2*pi])
view(90+dip,90)
title('Group velocity');
end
 
 pangle=theta1;
 pvelp=evp1;
 pvels=evs1;
 
 ganglep=ephi1;
 gvelp=evpg1;
 
 gangles=ephis1;
 gvels=evsg1;
end

