%*************************************************************************%
% Name	    ��An example of 2-order acoustic wave equation PS modeling
% Author	��C.F. Guo
% Date    	��2017-1-19
% Version	��1.0
%*************************************************************************%
Nx=300; 
Nz=300;
Nt=400;	
dt=0.001;
dx=10;
dz=10;	
sx=Nx/2;
sz=Nz/2;
P1=fzeros(Nx,Nz); 
P2=fzeros(Nx,Nz);  
P0=fzeros(Nx,Nz); 	
P1x=fzeros(Nx,Nz); 
P2x=fzeros(Nx,Nz);  
P0x=fzeros(Nx,Nz); 
P1z=fzeros(Nx,Nz); 
P2z=fzeros(Nx,Nz);  
P0z=fzeros(Nx,Nz); 
temp=fzeros(Nx,Nz); 
vp=3000*fones(Nx,Nz);		
loc=gfloc(Nz,Nx,sz,sx);
fm=30;lag=40; wlet=gfricker(Nt,fm,dt,lag);	
cn=dt.*dt.*vp.*vp;
[qz,qx]=gfpml(Nz,Nx,20,0.1);
Q=qx+qz;
pl=1./(1+Q*dt/2);
pm=(1-Q*dt/2);
plx=1./(1+qx*dt/2);
pmx=1-qx*dt/2;
plz=1./(1+qz*dt/2);
pmz=1-qz*dt/2;
[kz,kx]=gfkzkx(Nz,Nx,dz,dx);
KZ2=kz.*kz;
KX2=kx.*kx;
for it=1:Nt		
                    
%  P2=pl.*(2*P1-pm.*P0+cn.*(gfLx2(P1,dx)+gfLz2(P1,dz)))+loc*wlet(it);
%     P0=P1;              
%     P1=P2;
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
