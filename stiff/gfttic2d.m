function [c11t,c13t,c15t,c33t,c35t,c44t,c46t,c55t,c66t]=gfttic2d(c11,c13,c33,c44,c66,theta)
% GF2DTTIC rotates the 2D VTI symmetry to TTI symmetry by the theta (degree) angle
%   
%   call:
%
%   [c11,c13,c15,c33,c35,c44,c46,c55,c66]=gf2dttic(c11,c13,c33,c44,c66,theta)
%   
%   theta is in degree.
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

theta=theta/180*pi;
c11t=(c11.*cos(theta).^2 + c13.*sin(theta).^2).*cos((theta)).^2 + (c13.*cos(theta).^2 + c33.*sin(theta).^2).*sin((theta)).^2 + c44.*sin(2.*theta).*sin(2.*(theta));
c13t=(c13.*cos(theta).^2 + c33.*sin(theta).^2).*cos((theta)).^2 + (c11.*cos(theta).^2 + c13.*sin(theta).^2).*sin((theta)).^2 - c44.*sin(2.*theta).*sin(2.*(theta));

c15t=(sin(2.*(theta)).*(c11.*cos(theta).^2 + c13.*sin(theta).^2))./2 - (sin(2.*(theta)).*(c13.*cos(theta).^2 + c33.*sin(theta).^2))./2 - c44.*sin(2.*theta).*cos(2.*(theta));

c33t=(c33.*cos(theta).^2 + c13.*sin(theta).^2).*cos((theta)).^2 + (c13.*cos(theta).^2 + c11.*sin(theta).^2).*sin((theta)).^2 + c44.*sin(2.*theta).*sin(2.*(theta));

c35t=(sin(2.*(theta)).*(c13.*cos(theta).^2 + c11.*sin(theta).^2))./2 - (sin(2.*(theta)).*(c33.*cos(theta).^2 + c13.*sin(theta).^2))./2 + c44.*sin(2.*theta).*cos(2.*(theta));

c44t=c44.*cos((theta)).*cos(theta) + c66.*sin((theta)).*sin(theta);

c46t=c66.*cos((theta)).*sin(theta) - c44.*sin((theta)).*cos(theta);
c55t=(sin(2.*(theta)).*((c11.*sin(2.*theta))./2 - (c13.*sin(2.*theta))./2))./2 - (sin(2.*(theta)).*((c13.*sin(2.*theta))./2 - (c33.*sin(2.*theta))./2))./2 + c44.*cos(2.*theta).*cos(2.*(theta));

c66t=c66.*cos((theta)).*cos(theta) + c44.*sin((theta)).*sin(theta);

end
