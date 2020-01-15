function result = gfricci(i,j,k)
%GFRICCI return Ricci operator
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

df1=[1,2,3];
df2=[2,3,1];
df3=[3,1,2];

dr1=[3,2,1];
dr2=[2,1,3];
dr3=[1,3,2];

d=[i,j,k];

if sum(abs(d-df1))==0 || sum(abs(d-df2))==0 || sum(abs(d-df3))==0 
    result=1;
elseif sum(abs(d-dr1))==0 || sum(abs(d-dr2))==0 || sum(abs(d-dr3))==0 
    result=-1;
else
    result=0;
end

end

