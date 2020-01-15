%*************************************************************************%
% Name	    £ºAn example of 2-order acoustic wave equation FD modeling
%             (using high-order FD scheme compared with MAc2FDCPU2)
% Author	£ºC.F. Guo
% Date    	£º2017-1-19
% Version	£º3.0
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
vp=3000*fones(Nx,Nz);		
loc=gfloc(Nz,Nx,sz,sx);
fm=30;lag=40; wlet=gfricker(Nt,fm,dt,lag);	
cn=dt.*dt.*vp.*vp;	
for it=1:Nt		
                    
    P2=2*P1-P0+cn.*(gfLx2(P1,dx)+gfLz2(P1,dz))+loc*wlet(it);
    P0=P1;              
    P1=P2;             
end	
gfplot(P1);		
