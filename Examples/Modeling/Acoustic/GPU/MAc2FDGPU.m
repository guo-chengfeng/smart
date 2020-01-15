%*************************************************************************%
% Name	    £ºAn example of 2-order acoustic wave equation FD modeling 
%             using GPU
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

cn=dt*dt.*vp.*vp;
cn=gpuArray(cn);

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

for it=1:Nt
    P2x=plx.*(2*P1x-pmx.*P0x+cn.*Lx2(P1,dx));
    P2z=plz.*(2*P1z-pmz.*P0z+cn.*Lz2(P1,dz));
    P0x=P1x;
    P1x=P2x;
    P0z=P1z;
    P1z=P2z;
    P1=P1x+P1z+wlet(it)*loc;
end
    
gfplot(P1)

















