clear all
Nt=2000;
dt=0.001;
dx=10;
dz=10;
epsilon=0*ones(320,320);
delta=0*ones(320,320);
rho=2000*ones(320,320);
vp=3000*ones(320,320);

record_pml=zeros(Nt,1);
gama=epsilon*0.5;
vs=vp/1.73;
[Nz,Nx]=size(vp);
sx=Nx/2;

sz=Nz/2;

fm=20;        %domain frequence
delay=40;  
Npml=10;
ricker=glricker(Nt,fm,dt,delay);
loc=glsourcep(vp,sz,sx);

[Dxf,Dzf]=glcosatt(Nz,Nx,Npml,0.8,250);
Dxb=zeros(size(Dxf));
Dzb=zeros(size(Dzf));
for i=1:Npml
    Dxb(:,i)=Dxf(:,i+1);
    Dzb(i,:)=Dzf(i+1,:);
end

for i=Nx-Npml+1:Nx
    Dxb(:,i)=Dzf(:,i-1);
end
for i=Nz-Npml+1:Nz
    Dzb(i,:)=Dzf(i-1,:);
end
    
plpxf=1./(1+dt*Dxf/2);
plmxf=(1-dt*Dxf/2);
plpzf=1./(1+dt*Dzf/2);
plmzf=(1-dt*Dzf/2);


plpxf=1./(1+dt*Dxb/2);
plmxf=(1-dt*Dxb/2);
plpzb=1./(1+dt*Dzb/2);
plmzb=(1-dt*Dzb/2);

Vxx=zeros(Nz,Nx);
Vxz=zeros(Nz,Nx);
Vx=zeros(Nz,Nx);
Vzx=zeros(Nz,Nx);
Vzz=zeros(Nz,Nx);
Vz=zeros(Nz,Nx);
Txxx=zeros(Nz,Nx);
Txxz=zeros(Nz,Nx);
Txx=zeros(Nz,Nx);
Tzzx=zeros(Nz,Nx);
Tzzz=zeros(Nz,Nx);
Tzz=zeros(Nz,Nx);
Txzx=zeros(Nz,Nx);
Txzz=zeros(Nz,Nx);
Txz=zeros(Nz,Nx);

temp1=zeros(Nz,Nx);
temp2=zeros(Nz,Nx);

% record_vx=zeros(Nt,Nx-2*Npml);
% record_vz=zeros(Nt,Nx-2*Npml);


cp=dt./rho;
[c11, c13, c33, c44 ,c66]=gltho2elp(vp,vs,epsilon,gama,delta,rho);
c11=c11*dt;
c13=c13*dt;
c33=c33*dt;
c44=c44*dt;
c66=c66*dt;
tic
for k=1:Nt
    Vxx=plpxf.*(plmxf.*Vxx+cp.*Lx1(Txx,dx));
    Vxz=plpzf.*(plmzf.*Vxz+cp.*Lz1(Txz,dz));
    Vx=Vxx+Vxz;
    
    Vzx=plpxf.*(plmxf.*Vzx+cp.*Lx1(Txz,dx));
    Vzz=plpzb.*(plmzb.*Vzz+cp.*Lz1(Tzz,dz))+loc*ricker(k);
    Vz=Vzx+Vzz;
    
    temp1=Lx1(Vx,dx);
    temp2=Lz1(Vz,dz);
    Txxx=plpxf.*(plmxf.*Txxx+c11.*temp1);
    Txxz=plpzf.*(plmzf.*Txxz+c13.*temp2);
    Txx=Txxx+Txxz;
    
    Tzzx=plpxf.*(plmxf.*Tzzx+c13.*temp1);
    Tzzz=plpzf.*(plmzf.*Tzzz+c33.*temp2);
    Tzz=Tzzx+Tzzz;
    
    Txzx=plpxf.*(plmxf.*Txzx+c44.*Lx1(Vz,dx));
    Txzz=plpzb.*(plmzb.*Txzz+c44.*Lz1(Vx,dz));
    Txz=Txzx+Txzz;
    
    record_pml(k)=Vz(sx+50,sz+50);
   %µØÕð¼ÇÂ¼ 
%     record_vx(k,:)=Vx(sz,Npml+1:Nx-Npml);
%     record_vz(k,:)=Vz(sz,Npml+1:Nx-Npml);
    
%      k
% 
    imagesc(Txx);
    colormap(gray);
    getframe;
end
toc
Vzz=Vz(11:310,11:310);
glwritesu(Vzz,dt,'Shot_1100_PML_Vz.su');
glwritesu(record_pml,0.001,'Record_PML_Vz.su');
% glwritesu(record_vz,dt,'record_vz.su');


    
    
    
    
    



