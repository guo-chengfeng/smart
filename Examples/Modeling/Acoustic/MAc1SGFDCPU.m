%*************************************************************************%
% Name	    £ºAn example of 1-order acoustic wave equation staggered-grid 
%             FD modeling
% Author	£ºC.F. Guo
% Date    	£º2017-1-19
% Version	£º1.0
%*************************************************************************%
Nx=300; 
Nz=300;
Nt=400;	
dt=0.001;
dx=10;
dz=10;	
sx=Nx/2;
sz=Nz/2;
P=fzeros(Nx,Nz); 
Px=fzeros(Nx,Nz);  
Pz=fzeros(Nx,Nz); 	
Vx=fzeros(Nx,Nz); 
Vz=fzeros(Nx,Nz);  
 
vp=3000*fones(Nx,Nz);	
rho=2000*fones(Nx,Nz);	
loc=gfloc(Nz,Nx,sz,sx);
fm=30;lag=40; wlet=gfricker(Nt,fm,dt,lag);	
cn=dt.*vp.*vp.*rho;
cp=dt./rho;
[qz,qx]=gfpml(Nz,Nx,20,0.1);
plx=1./(1+qx*dt/2);
pmx=1-qx*dt/2;
plz=1./(1+qz*dt/2);
pmz=1-qz*dt/2;

for it=1:Nt		
        
    Px=plx.*(pmx.*Px+cn.*sbLx(Vx,dx));
    Pz=plz.*(pmz.*Pz+cn.*sbLz(Vz,dz));
    P=Px+Pz+loc*wlet(it);

    Vx=plx.*(pmx.*Vx+cp.*sfLx(P,dx));
    Vz=plz.*(pmz.*Vz+cp.*sfLz(P,dz));
 
end	
gfplot(P);		
