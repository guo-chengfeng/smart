function wavelet = gfwletgpcm(Nt,dt,fm,fp,delay)
%GFWLETGPCM  returns a Gaussian pulse modulated by cos function
%
%   call:
%
%   wavelet = gfwletgpcm(Nt,dt,fm,fp,delay) creats a Gaussian pulse
%        modulated by cos(fp*2*pi*t)
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
if nargin<5
    delay=50;
end 

if nargin <4
    fp=50;
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
for i=1:Nt
    wavelet(i)=cos(fp*2*pi*(i-delay)*dt)*exp(-(i-delay)^2*dt^2*(pi*fm)^2);

end
end
