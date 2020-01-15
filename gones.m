function data = gones(varargin)
%GONES single precision version of Ones array on GPU
%
%     GONES(N) is an N-by-N matrix of ones.
%
%     GONES(M,N) or ONES([M,N]) is an M-by-N matrix of ones.
%
%     GONES(M,N,P,...) or ONES([M N P ...]) is an M-by-N-by-P-by-... array of
%     ones.
%
%     GONES(SIZE(A)) is the same size as A and all ones.
%
%     GONES with no arguments is the scalar 1.
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/12 
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

isfind=gffindflag(varargin,'single');
if isfind
    data=gpuArray.ones(varargin{:});
else
    data=gpuArray.ones(varargin{:},'single');
end

end



