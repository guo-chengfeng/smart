%*************************************************************************%
% Name	    £ºAn example of 2-order acoustic wave equation FD modeling          
% Author	£ºC.F. Guo
% Date    	£º2017-1-19
% Version	£º1.0 (naive version)
%*************************************************************************%
Nx=300; 
Nz=300;
Nt=400;	
dt=0.001;
dx=10;
dz=10;	
P1=fzeros(Nx,Nz); 
P2=fzeros(Nx,Nz);  
P0=fzeros(Nx,Nz); 	
vp=3000*fones(Nx,Nz);	
loc=fzeros(Nx,Nz); loc(Nx/2,Nz/2)=1;	
fm=30;lag=40; wlet=gfricker(Nt,fm,dt,lag);	
cn=dt.*dt.*vp.*vp;	
mx=[1,-2,1]/dx/dx;mz=[1,-2,1]'/dz/dz;	
for it=1:Nt		
                    
    P2=2*P1-P0+ cn.*(conv2(P1,mx,'same')+conv2(P1,mz,'same'))+loc*wlet(it);
    P0=P1;              
    P1=P2;             
end	
gfplot(P1);		
