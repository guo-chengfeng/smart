%*************************************************************************%
% Name	    ：An example of 2-order acoustic wave equation PS modeling 
%             using GPU
% Author	：C.F. Guo
% Date    	：2017-1-19
% Version	：1.0
%*************************************************************************%

Nx=300; 
Nz=300;
Nt=400;	
dt=0.001;
dx=10;
dz=10;	
sx=Nx/2;
sz=Nz/2;
P1=gzeros(Nx,Nz); 	   %GPU内存开辟
P1x=gzeros(Nx,Nz); 
P2x=gzeros(Nx,Nz);  
P0x=gzeros(Nx,Nz); 
P1z=gzeros(Nx,Nz); 
P2z=gzeros(Nx,Nz);  
P0z=gzeros(Nx,Nz); 
temp=gzeros(Nx,Nz); 
vp=3000*fones(Nx,Nz);		
loc=gfloc(Nz,Nx,sz,sx);
fm=30;lag=40; wlet=gfricker(Nt,fm,dt,lag);	
cn=dt.*dt.*vp.*vp;
cn=gpuArray(cn);       %导入数据至GPU
[qz,qx]=gfpml(Nz,Nx,20,0.1);
Q=qx+qz;
pl=1./(1+Q*dt/2);
pm=(1-Q*dt/2);
plx=1./(1+qx*dt/2);
pmx=1-qx*dt/2;
plz=1./(1+qz*dt/2);
pmz=1-qz*dt/2;
plx=gpuArray(plx);
plz=gpuArray(plz);
pmx=gpuArray(pmx);
pmz=gpuArray(pmz);
[kz,kx]=gfkzkx(Nz,Nx,dz,dx);
KZ2=kz.*kz;
KX2=kx.*kx;
KZ2=gpuArray(KZ2);
KX2=gpuArray(KX2);
for it=1:Nt		
                    
    temp=fft2(P1);
    P2x=plx.*(2*P1x-pmx.*P0x-cn.*ifft2(temp.*KX2));
    P2z=plz.*(2*P1z-pmz.*P0z-cn.*ifft2(temp.*KZ2));
    P0x=P1x;              
    P1x=P2x;
    P0z=P1z;              
    P1z=P2z;
    P1=P1x+P1z+loc*wlet(it); 
    
end	
gfplot(P1);		
