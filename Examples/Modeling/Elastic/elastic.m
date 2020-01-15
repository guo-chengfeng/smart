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
    
    Vxx=plx.*(pmx.*Vxx+cp.*sfLx(Txx,dx));
    Vxz=plz.*(pmz.*Vxz+cp.*sbLz(Txz,dz));
    Vx=Vxx+Vxz;
    
    Vzx=plx.*(pmx.*Vzx+cp.*sbLx(Txz,dx));
    Vzz=plz.*(pmz.*Vzz+cp.*sfLz(Tzz,dz));
    Vz=Vzx+Vzz;

    temp1=sbLx(Vx,dx);
    temp2=sbLz(Vz,dz);
    
    Txxx=plx.*(pmx.*Txxx+c11.*temp1);
    Txxz=plz.*(pmz.*Txxz+c13.*temp2);
    Txx=Txxx+Txxz+wlet(it)*loc;
    
    Tzzx=plx.*(pmx.*Tzzx+c13.*temp1);
    Tzzz=plz.*(pmz.*Tzzz+c33.*temp2);
    Tzz=Tzzx+Tzzz+wlet(it)*loc;
    
    Txzx=plx.*(pmx.*Txzx+c44.*sfLx(Vz,dx));
    Txzz=plz.*(pmz.*Txzz+c44.*sfLz(Vx,dz));
    Txz=Txzx+Txzz;

end
gfplot(Txx)
