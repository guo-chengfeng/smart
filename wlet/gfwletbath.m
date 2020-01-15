function bath = gfwletbath(Nt,dt,flag,vp,r,z)
% GFWLETBATH creates the explosion wavelet 
%
%   call:
%
%   bath = gfwletbath(Dt,dt,flag,vp,r,z) creates  the explosion  wavelet 
%   If flag=1 return the displacement else return particle velocity wavelet
%   'z' represents the wavelet at 'zm(unit: metre)' distance.
%   'r' is the explosion radius
%   'vp' is propagation velocity
%   'dt' is time sampling step
%
%   Reference: Analysis on feature of common analytic wavelets,2007,Zhang 
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
if nargin<6
    z=50;
end
if nargin<5
    r=10;
end
if nargin<4
    vp=1500;
end
if nargin<3
    flag=1;
end
if nargin<2
    dt=0.001;
end
if nargin<1
    Nt=128;
end

t=(1:Nt)*dt;
A=1;
b=2*vp/3/r;
B=b*t;
c=sqrt(2)*b;
C=c*t;

bath=A*exp(-B).*((z-r/2).*sqrt(2).*sin(C)-r.*cos(C));
if flag ~=1
bath=-A*b*exp(-B).*((z-r/2).*sqrt(2).*sin(C)-r.*cos(C))+ ...
    +A*exp(-B).*(c*(z-r/2).*sqrt(2).*cos(C)+c*r.*sin(C));
end
bath=bath./max(abs(bath));
end

