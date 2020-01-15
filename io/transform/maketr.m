function maketr()
% compile IBM and 32-bit IEEE floating-point data transform functions
%
%
pctype=computer();
opath=pwd;
ipath=which('maketr');
ipath(end-8:end)=[];
cd(ipath);
switch pctype
    case 'PCWIN'
        mex gfmxibm2ieeePCWIN.c
        mex gfmxieee2ibmPCWIN.c
    case 'PCWIN64'
        mex gfmxibm2ieeePCWIN64.c
        mex gfmxieee2ibmPCWIN64.c
    case 'GLNX86'
        mex gfmxibm2ieeeGLNX86.c
        mex gfmxieee2ibmGLNX86.c
    case 'GLNXA64'
        mex gfmxibm2ieeeGLNXA64.c
        mex gfmxieee2ibmGLNXA64.c
    otherwise
        nnerr.throw('Error: SMART does not support this system architecture');
        cd(opath);
end
cd(opath);
end