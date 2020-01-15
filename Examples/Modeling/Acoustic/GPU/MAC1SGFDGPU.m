%*************************************************************************%
% Name	    £ºAn example of 1-order acoustic wave equation staggered-grid
%             FD modeling using GPU
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

for it=1:Nt
    Px=plx.*(pmx.*Px+cn.*sfLx(Vx,dx));
    Pz=plz.*(pmz.*Pz+cn.*sfLz(Vz,dz));
    P=Px+Pz+wlet(it)*loc;
    
    Vx=plx.*(pmx.*Vx+cp.*sbLx(P,dx));
    Vz=plz.*(pmz.*Vz+cp.*sbLz(P,dz));
    
end
    
gfplot(P)






