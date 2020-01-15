%*************************************************************************%
% Name	    £ºAn example of 1-order acoustic wave equation rotated 
%             staggered-grid FD modeling using CUDA C
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


%rotated staggered-grid finite-difference. Pass test! 
rsgffdCuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','rsgffd');
rsgbfdCuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','rsgbfd');

rsgffdCuda.ThreadBlockSize=[32,32,1];
rsgffdCuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];

rsgbfdCuda.ThreadBlockSize=[32,32,1];
rsgbfdCuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];

tpx=gzeros(Nz,Nx);
tpz=gzeros(Nz,Nx);
coef=fdcoef(1,6,'s');

for it=1:Nt
    

    [tpx,tpz]=feval(rsgffdCuda,Vx,tpx,tpz,Nz,Nx,coef);
    Px=plx.*(pmx.*Px+0.5*cn.*(tpz+tpx)/dx);
    [tpx,tpz]=feval(rsgffdCuda,Vz,tpx,tpz,Nz,Nx,coef);
    Pz=plz.*(pmz.*Pz+0.5.*cn.*(tpz-tpx)/dz);
    P=Px+Pz+wlet(it)*loc;
    

    [tpx,tpz]=feval(rsgbfdCuda,P,tpx,tpz,Nz,Nx,coef);
    Vx=plx.*(pmx.*Vx+0.5.*cp.*(tpz+tpx)/dx);
    Vz=plz.*(pmz.*Vz+0.5.*cp.*(tpz-tpx)/dz);
    
end
    
gfplot(P)
