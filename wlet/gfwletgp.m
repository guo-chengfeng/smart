function wavelet = gfwletgp(Nt,dt,fm,delay)
%GFWLETGP  returns a Gaussian pulse 
%
%   call:
%
%   wavelet = gfwletgp( Nt,dt,fm,delay)
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
if nargin<4
    delay=50;
end 

if nargin<3
   fm=30;
end 

if nargin<2
    dt=0.001;
end 

if nargin<1
    Nt=128;
end 

wavelet=fzeros(1,Nt);
for i=0:Nt-1
    wavelet(i+1)=exp(-(i-delay)^2*dt^2*pi*pi*fm*fm);
end
end
