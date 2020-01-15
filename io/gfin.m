function data= gfin(path,varargin)
%GFIN reads data from a file.
%
%   call:
%
%   data = gfin(path) reads whole data. the defualt file format is SEGY
%   data = gfin(path,fileFormat) reads data from following 'fileFormat' file:
%        'dat' : the file is pure binary data without any kind header
%        'su'  : the file is little-endian floating IEEE SU data
%        'segy': the file is IEEE little-endian or IBM big-endian floating 
%                SEGY data, default file format is SEGY.
%        'hdr' : read the 240-byte binary trace header of SEGY file
%   data = gfin(fileName,fileFormat,startAt,endAt) reads data from startAt trace to
%        the endAt trace from the 'fileFormat' file
%
%   Note: Parameter 'fileFormat' can be at any position for convenience,
%   excepting the first position
%
%   Example:
%   read data from a pure binary file:
%   dat=gfin(fileName,'dat',Nz,Nx)
%   dat=gfin(fileName,'dat',Nz,Nx,startAt)
%   dat=gfin(fileName,'dat',Nz,Nx,startAt,endAt)
%
%   read data from a SU file:
%   dat=gfin(fileName,'su')
%   dat=gfin(fileName,'su',startAt)
%   dat=gfin(fileName,'su',startAt,endAt)
%
%   read data from a SEGY file:
%   dat=gfin(fileName)
%   dat=gfin(fileName,startAt)
%   dat=gfin(fileName,startAt,endAt)
%
%   read trace header from a SEGY file:
%   dat=gfin(fileName,'hdr')
%   dat=gfin(fileName,'hdr',startAt)
%   dat=gfin(fileName,'hdr',startAt,endAt)
%   
%   See also gfout gfreadfile gfreadsu gfreadsegy gfreadgpr gfreadat
%   gfreadhdr gfreadsegyhdr and gfreadmala 
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

if nargin==1
    dat_type='segy';
end
nv1=numel(varargin);
nv=nv1;
if nv1>0
    for i=1:nv1
        if ischar(varargin{i})
            dat_type=varargin{i};
            nv=nv1-1;
            varargin{i}=[];
            break;
        end
    end
    
    if nv1==nv
        dat_type='segy';
    end
end


varmat=cell2mat(varargin);

switch dat_type
    case 'dat'
        if nv==0
            data=gfreadat(path);
        elseif nv==1
            data=gfreadat(path,varmat(1));
        else
            data=gfreadat(path,varmat(1),varmat(2));
        end
        
    case 'su'
        if nv==0
            data=gfreadsu(path);
        elseif nv==1
            data=gfreadsu(path,varmat(1));
        else
            data=gfreadsu(path,varmat(1),varmat(2));
        end
    case 'hdr'
        if nv==0
            data=gfreadhdr(path);
        elseif nv==1
            data=gfreadhdr(path,varmat(1));
        else
            data=gfreadhdr(path,varmat(1),varmat(2));
        end
    case 'segy'
        if nv==0
            data=gfreadsegy(path);
        elseif nv==1
            data=gfreadsegy(path,varmat(1));
        else
            data=gfreadsegy(path,varmat(1),varmat(2));
        end
    otherwise
        nnerr.throw('Unrecognized data format');
end
end




