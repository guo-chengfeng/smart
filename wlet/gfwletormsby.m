function wlet = gfwletormsby(Nt,dt,lag,f1,f2,f3,f4)
%GFWLETORMSBY Creates an Ormsby bandpass filter, modified form the CREWES'
%  function version, ORMSBY
%  
% call:
%
% wavelet = gfwletormsby(Nt,dt,lag,f1,f2,f3,f4) creates a ormsby wavelet 
%   given the four frequency parameters
%   f1 = low frequency stop
%   f2 = lowest frequency to pass unattenuated
%   f3 = highest frequency to pass attenuated
%   f4 = high frequency stop
%   Nt = wavelet length (=Nt*dt)
%   dt = wavelet sample rate in seconds
%   lag = the maximum amplitude appearing moment (lag*dt) with respect to the
%       monment t=0.
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
if nargin<7
    f4=60;
end
if nargin<6
    f3=50;
end
if nargin<5
    f2=10;
end
if nargin<4
    f1=5;
end
if nargin<3
    lag=64;
end
if nargin<2
    dt=0.001;
end
if nargin<1
    Nt=128;
end


    t=[0:1:Nt]*dt;
    lag=lag*dt;
%make the wavelet

	w= (pi*f4^2) * (sinc(pi*f4*(t-lag))).^2/(f4-f3);
	w= w- (pi*f3^2) * (sinc(pi*f3*(t-lag))).^2/(f4-f3);
	w= w- (pi*f2^2) * (sinc(pi*f2*(t-lag))).^2/(f2-f1);
	w= w+ (pi*f1^2) * (sinc(pi*f1*(t-lag))).^2/(f2-f1);
    
    wlet=w./max(w);
end

