function CTTI = gfttic3d( CVTI,theta,phi )
% GFTTIC3D calculates the TTI stiffness matrix from VTI case 
% call:
%
% CTTI = gfttic3d( CVTI, theta, phi ) 
%   CVTI is the VTI stiffness matrix
%   theta is the polarity angle in degree (relative to Z-axis)
%   phi is the azimuthal angle in degree (relative to X-axis)
% 
%    Version: V1.0
%    Author : C.F.Guo
%    Time   : 2016/4/12 
%  
%  ------------------------------NOTE---------------------------------------
%  
%  This a subroutine of Seismic Modeling and Research Toolkit (SMART),
%  It is illegal for you to use this software tool (Seismic Modeling and 
%  Research Toolkit,SMART) for a purpose other than non-profit education 
%  or research UNLESS you are authorized by the Seismic Modeling Project.If 
%  you find any problems, please connect the Author(s): chf_guo@163.com
%   
%  by C.F. Guo, 2015
%   
%  Copyright(C) 2015 Elastic Wave Expolration Project (EWEP)
%  China University of Petroleum(East China)




theta=theta/180*pi;
 phi=phi/180*pi;
 sintheta2=sin(theta)*sin(theta);
 costheta2=cos(theta)*cos(theta);
 sin2theta=sin(2*theta);
 cos2theta=cos(2*theta);
 
 sinphi2=sin(phi)*sin(phi);
 cosphi2=cos(phi)*cos(phi);
 sin2phi=sin(2*phi);
 cos2phi=cos(2*phi);
 
 Etheta=[costheta2,0,sintheta2,0,-sin2theta,0;
     0,1,0,0,0,0;
     sintheta2,0,costheta2,0,sin2theta,0;
     0,0,0,cos(theta),0,sin(theta);
     0.5*sin2theta,0,-0.5*sin2theta,0,cos2theta,0;
     0,0,0,-sin(theta),0,cos(theta);];
 
 Ephi=[cosphi2,sinphi2,0,0,0,-sin2phi;
       sinphi2,cosphi2,0,0,0,sin2phi;
       0,0,1,0,0,0;
       0,0,0,cos(phi),sin(phi),0;
       0,0,0,-sin(phi),cos(phi),0;
       0.5*sin2phi,-0.5*sin2phi,0,0,0,cos2phi;];
 CTTI=Ephi*Etheta*CVTI*Etheta'*Ephi';
  
end

