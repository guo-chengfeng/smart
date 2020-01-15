%*************************************************************************%
% Name	    £ºAn example of 2-order acoustic wave equation FD modeling using CUDA C
% Author	£ºC.F. Guo
% Date    	£º2017-1-19
% Version	£º1.0
%*************************************************************************%

Nz=400;
Nx=400;
vp=3000*gones(Nz,Nx);
sx=Nx/2;
sz=Nz/2;
dx=10;
dz=10;
dt=0.001;

P0=gzeros(Nz,Nx);
P1=gzeros(Nz,Nx);
P2=gzeros(Nz,Nx);
P1x=gzeros(Nz,Nx);
P1z=gzeros(Nz,Nx);
P0x=gzeros(Nz,Nx);
P0z=gzeros(Nz,Nx);
P2x=gzeros(Nz,Nx);
P2z=gzeros(Nz,Nx);

cnx=dt*dt.*vp.*vp/dx/dx;
cnx=gpuArray(single(cnx));
cnz=dt*dt.*vp.*vp/dz/dz;
cnz=gpuArray(single(cnz));

fm=30;
Nt=800;
dt=0.001;
lag=40;
wlet=gfricker(Nt,dt,fm,lag);
loc=gfloc(Nz,Nx,sz,sx);
loc=gpuArray(loc);


[pz,px]=gfpml(Nz,Nx,40,0.1);
plx=1./(1+dt*px/2);
pmx=(1-dt*px/2);
plz=1./(1+dt*pz/2);
pmz=(1-dt*pz/2);

plx=gpuArray(plx);
pmx=gpuArray(pmx);
plz=gpuArray(plz);
pmz=gpuArray(pmz);


coef=fdcoef(2,5);
LxCuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','Lx2');
LzCuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','Lz2');
LxCuda.ThreadBlockSize=[32,32,1];
LxCuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
LzCuda.ThreadBlockSize=[32,32,1];
LzCuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
tpx=gzeros(Nz,Nx);
tpz=gzeros(Nz,Nx);

disp('CUDA finite-difference for 2nd-order derivative:');
tic
for it=1:Nt
    tpx=feval(LxCuda,P1,tpx,Nz,Nx,coef);
    tpz=feval(LzCuda,P1,tpz,Nz,Nx,coef);
    
    P2x=plx.*(2*P1x-pmx.*P0x+cnx.*tpx);
    P2z=plz.*(2*P1z-pmz.*P0z+cnz.*tpz);
    P0x=P1x;
    P1x=P2x;
    P0z=P1z;
    P1z=P2z;
    P1=P1x+P1z+wlet(it)*loc;
    
end
 toc   
gfplot(P1)

















