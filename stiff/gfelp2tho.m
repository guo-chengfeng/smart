function  [Vp,Vs,epsilon,gama,delta] = gfelp2tho(c11,c13,c33,c44,c66,rho )
%GFELP2THO   transforms elstic stiff to Thomsen parameters
%
%   call:
%
%   [Vp,Vs,epsilon,gama,delta] = gfelp2tho(c11,c13,c33,c44,c66,rho )
%   Sequence of output is Vp,Vs,epsilon,gama,delta
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2013/9/11 
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

Vp=sqrt(c33./rho);
Vs=sqrt(c44./rho);
epsilon=(c11-c33)./2./(c33+eps);
gama=(c66-c44)./2./(c44+eps);
delta=((c13+c44).^2-(c33-c44).^2)./2./(c33+eps)./(c33-c44+eps);

end

