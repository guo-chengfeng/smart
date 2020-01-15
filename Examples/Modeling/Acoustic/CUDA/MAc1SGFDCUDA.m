%*************************************************************************%
% Name	    £ºAn example of 1-order acoustic wave equation staggered-grid
%             FD modeling using CUDA C
% Author	£ºC.F. Guo
% Date    	£º2017-1-19
% Version	£º1.0
%*************************************************************************%

Nz=400;
Nx=400;
vp=3000*gones(Nz,Nx);
rho=2000*gones(Nz,Nx);
sx=Nx/2;
sz=Nz/2;
dx=10;
dz=10;
dt=0.001;

P=gzeros(Nz,Nx);
Px=gzeros(Nz,Nx);
Pz=gzeros(Nz,Nx);
Vx=gzeros(Nz,Nx);
Vz=gzeros(Nz,Nx);

cn=dt.*vp.*vp.*rho;
cn=gpuArray(cn);
cp=gpuArray(dt./rho);

fm=30;
Nt=800;
dt=0.001;
lag=40;
wlet=gfricker(Nt,dt,fm,lag);
loc=gfloc(Nz,Nx,sz,sx);
loc=gpuArray(loc);


[pz,px]=gfpml(Nz,Nx,20,0.1);
plx=1./(1+dt*px/2);
pmx=(1-dt*px/2);
plz=1./(1+dt*pz/2);
pmz=(1-dt*pz/2);

plx=gpuArray(plx);
pmx=gpuArray(pmx);
plz=gpuArray(plz);
pmz=gpuArray(pmz);


sbLxCuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','sbLx');
sfLxCuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','sfLx');
sbLzCuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','sbLz');
sfLzCuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','sfLz');

sbLxCuda.ThreadBlockSize=[32,32,1];
sbLxCuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];

sbLzCuda.ThreadBlockSize=[32,32,1];
sbLzCuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];

sfLxCuda.ThreadBlockSize=[32,32,1];
sfLxCuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];

sfLzCuda.ThreadBlockSize=[32,32,1];
sfLzCuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
tpx=gzeros(Nz,Nx);
tpz=gzeros(Nz,Nx);
coef=fdcoef(1,6,'s');

for it=1:Nt
    
    tpx=feval(sfLxCuda,Vx,tpx,Nz,Nx,coef);
    tpz=feval(sfLzCuda,Vz,tpz,Nz,Nx,coef);
    
    Px=plx.*(pmx.*Px+cn.*tpx/dx);
    Pz=plz.*(pmz.*Pz+cn.*tpz/dz);
    P=Px+Pz+wlet(it)*loc;
    
    tpx=feval(sbLxCuda,P,tpx,Nz,Nx,coef);
    tpz=feval(sbLzCuda,P,tpz,Nz,Nx,coef);
    
    Vx=plx.*(pmx.*Vx+cp.*tpx/dx);
    Vz=plz.*(pmz.*Vz+cp.*tpz/dz);
    
end
    
gfplot(P)

















