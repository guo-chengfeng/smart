function ricker=gfwletzinc(Nt,dt,fl,fh,delay)
% GFWLETZINC  creates the Zinc wavelet 
%
%   call:
%
%   zinc = gfwletzinc(Nt,dt,fl,fh,delay) creates  the Zinc wavelet 
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
    delay=64;
end

if nargin<4
    fh=50;
end

if nargin<3
    fl=10;
end
if nargin<2
    dt=0.001;
end

if nargin<1
    Nt=128;
end
ricker=gzeros(1,Nt);

for i=1:Nt
ricker(i)=2*fh*sin(2*pi*fh*(i-delay)*dt)/2/pi/fh/((i-delay)*dt) ...
         -2*fl*sin(2*pi*fl*(i-delay)*dt)/2/pi/fl/((i-delay)*dt);
if isnan(ricker(i))
    ricker(i)=2*fh-2*fl;
end

end

data=ricker./max(ricker);
% [val index]=max(data);
% dd=0;
% for i=index:Nt
%     if data(i-1)>data(i) && data(i+1)>data(i)
%         dd=dd+1;
%     end
%     if dd==2
%         break;
%     end
% end
% 
% for j=i:Nt
%     if data(j)>0;
%         break;
%     end
% end
% 
% for k=j:Nt
%     data(k)=0;
% end
% 
% 
% dd=0;
% for i=index:-1:2
%     if data(i-1)>data(i) && data(i+1)>data(i)
%         dd=dd+1;
%     end
%     if dd==2
%         break;
%     end
% end
% 
% for j=i:-1:2
%     if data(j)>0;
%         break;
%     end
% end
% 
% for k=j:-1:2
%     data(k)=0;
% end
% data(1)=0;
ricker=data;

end