
Nt=1000;
dt=0.001;
dx=10;
dz=10;
epsilon=0*ones(300,300);
delta=0*ones(300,300);
rho=2000*ones(300,300);
vp=3000*ones(300,300);

record_pml=zeros(Nt,1);
gama=epsilon*0.5;
vs=0*vp/1.73;
[Nz,Nx]=size(vp);
sx=Nx/2;

sz=Nz/2;
line=zeros(1,Nt);

fm=20;        %domain frequence
delay=40;  
Npml=20;
ricker=glricker(Nt,fm,dt,delay);
loc=glsourcep(vp,sz,sx);
% for i=1:Npml
%     Dxb(:,i)=Dxf(:,i+1);
%     Dzb(i,:)=Dzf(i+1,:);
% end
% 
% for i=Nx-Npml+1:Nx
%     Dxb(:,i)=Dxf(:,i-1);
% end
% for i=Nz-Npml+1:Nz
%     Dzb(i,:)=Dzf(i-1,:);
% end
[Dxf,Dzf]=glcosatt(Nz,Nx,Npml,0.8,300);
Dxb=zeros(size(Dxf));
Dzb=zeros(size(Dzf));
for i=2:Npml+1
    Dxb(:,i)=Dxf(:,i-1);
    Dzb(i,:)=Dzf(i-1,:);
end

for i=Nx-Npml+2:Nx
    Dxb(:,i)=Dxf(:,i-1);
end
for i=Nz-Npml+2:Nz
    Dzb(i,:)=Dzf(i-1,:);
end
    
plpxf=1./(1+dt*Dxf/2);
plmxf=(1-dt*Dxf/2);
plpzf=1./(1+dt*Dzf/2);
plmzf=(1-dt*Dzf/2);


plpxb=1./(1+dt*Dxb/2);
plmxb=(1-dt*Dxb/2);
plpzb=1./(1+dt*Dzb/2);
plmzb=(1-dt*Dzb/2);

% plpxb=1./(1+dt*Dxf/2);
% plmxb=(1-dt*Dxf/2);
% plpzb=1./(1+dt*Dzf/2);
% plmzb=(1-dt*Dzf/2);

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
%     Vxx=plpxf.*(plmxb.*Vxx+cp.*sbLx(Txxx,dx));
%     Txxx=plpxb.*(plmxb.*Txxx+c11.*sfLx(Vxx,dx))+loc*ricker(k);
%  
%     line(k)=Vxx(sz,sx+100);
%     line2(k)=Vxx(sz,sx-100);
    imagesc(Txx);
    colormap(gray);
    getframe;
% k

    Vxx=plpxf.*(plmxb.*Vxx+cp.*sbLx1(Txx,dx));
    Vxz=plpzb.*(plmzb.*Vxz+cp.*sfLz1(Txz,dz));
    Vx=Vxx+Vxz;
    
    Vzx=plpxb.*(plmxb.*Vzx+cp.*sfLx1(Txz,dx));
    Vzz=plpzf.*(plmzb.*Vzz+cp.*sbLz1(Tzz,dz));
    Vz=Vzx+Vzz;
    
    temp1=sfLx1(Vx,dx);
    temp2=sfLz1(Vz,dz);
    Txxx=plpxb.*(plmxb.*Txxx+c11.*temp1);
    Txxz=plpzb.*(plmzb.*Txxz+c13.*temp2)+loc*ricker(k);
    Txx=Txxx+Txxz;
    
    Tzzx=plpxb.*(plmxb.*Tzzx+c13.*temp1);
    Tzzz=plpzb.*(plmzb.*Tzzz+c33.*temp2)+loc*ricker(k);
    Tzz=Tzzx+Tzzz;
    
    Txzx=plpxf.*(plmxb.*Txzx+c44.*sbLx1(Vz,dx));
    Txzz=plpzf.*(plmzb.*Txzz+c44.*sbLz1(Vx,dz));
    Txz=Txzx+Txzz;
    
     line(k)=Txx(sz+100,sx);

end
toc
% Vzz=Vz(11:310,11:310);
% glwritesu(Vzz,dt,'Shot_1100_PML_Vz.su');
% glwritesu(record_pml,0.001,'Record_PML_Vz.su');
% glwritesu(record_vz,dt,'record_vz.su');
plot(line./max(abs(line)))
hold on
plot(line2./max(abs(line2)),'r')


    
    
    
    
    



