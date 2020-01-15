%*************************************************************************%
% Name	    £ºAn example of 2-order acoustic wave equation FD modeling
% Author	£ºC.F. Guo
% Date    	£º2017-1-19
% Version	£º5.0
%*************************************************************************%
% compare the computional cost
tic
dt=0.001;
dx=10;
dz=10;

vp=3000*fones(300,300);
vs=vp./1.73;
rho=vp/1.5;

[Nz,Nx]=size(vp);
sx=Nx/2;
sz=Nz/2;
Nt=600;
fm=30;        %domain frequence
delay=40;
Npml=20;
wlet=gfricker(Nt,fm,dt,delay);
loc=gfloc2(vp,sz,sx);

Vz=fzeros(Nz,Nx);
Vzx=fzeros(Nz,Nx);
Vzz=fzeros(Nz,Nx);
Vx=fzeros(Nz,Nx);
Vxx=fzeros(Nz,Nx);
Vxz=fzeros(Nz,Nx);

Txx=fzeros(Nz,Nx);
Txxx=fzeros(Nz,Nx);
Txxz=fzeros(Nz,Nx);

Tzz=fzeros(Nz,Nx);
Tzzx=fzeros(Nz,Nx);
Tzzz=fzeros(Nz,Nx);

Txz=fzeros(Nz,Nx);
Txzx=fzeros(Nz,Nx);
Txzz=fzeros(Nz,Nx);

c11=dt.*vp.*vp.*rho;
c33=dt.*vp.*vp.*rho;
c13=dt.*rho.*(vp.*vp-2.*vs.*vs);
c44=vs.*vs.*dt.*rho;
cp=dt./rho;

[qz,qx]=gfpml(Nz,Nx,20,0.1);
plx=1./(1+qx*dt/2);
pmx=1-qx*dt/2;
plz=1./(1+qz*dt/2);
pmz=1-qz*dt/2;

for it=1:Nt
    
    Vxx=plx.*(pmx.*Vxx+cp.*sbLx(Txx,dx));
    Vxz=plz.*(pmz.*Vxz+cp.*sfLz(Txz,dz));
    Vx=Vxx+Vxz;
    
    Vzx=plx.*(pmx.*Vzx+cp.*sfLx(Txz,dx));
    Vzz=plz.*(pmz.*Vzz+cp.*sbLz(Tzz,dz));
    Vz=Vzx+Vzz;

    temp1=sfLx(Vx,dx);
    temp2=sfLz(Vz,dz);
    
    Txxx=plx.*(pmx.*Txxx+c11.*temp1);
    Txxz=plz.*(pmz.*Txxz+c13.*temp2);
    Txx=Txxx+Txxz+wlet(it)*loc;
    
    Tzzx=plx.*(pmx.*Tzzx+c13.*temp1);
    Tzzz=plz.*(pmz.*Tzzz+c33.*temp2);
    Tzz=Tzzx+Tzzz+wlet(it)*loc;
    
    Txzx=plx.*(pmx.*Txzx+c44.*sbLx(Vz,dx));
    Txzz=plz.*(pmz.*Txzz+c44.*sbLz(Vx,dz));
    Txz=Txzx+Txzz;

end
gfplot(Txx)
