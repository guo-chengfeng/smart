function [c11,c13,c33,c44,c66] = gftho2elp(vp,vs,epsilon,gama,delta,rho)
%GFTHO2ELP  transforms Thomsen parameters to elstic stiff 
%
%   call:
%
%   [c11,c13,c33,c44,c66]=gftho2elp(vp,vs,epsilon,gama,delta,rho)
%   Sequence of intput is Vp,Vs,epsilon,gama,delta
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
f=1-vs.*vs./(vp.*vp+eps);
c11=rho.*(1+2.*epsilon).*vp.*vp;
c33=rho.*vp.*vp;
c13=rho.*vp.*vp.*sqrt(f.*(f+2.*delta))-rho.*vs.*vs;
c44=rho.*vs.*vs;
c66=rho.*(1+2.*gama).*vs.*vs;

end

