Nz=400;
Nx=400;

cm=[0.1247576e+1,-0.1174969e+0,0.2997288e-1,-0.8741572e-2,0.2262285e-2,-0.3745306e-3];
%cm=gfcoefopt('cm2');
% cm=gfcoef(6);
cm=single(gpuArray(cm));
vp=3000*gpuArray.ones(Nz,Nx,'single');

dx=10;
dz=10;
dt=0.001;
rho=2000;
cc=vp.*vp.*dt*rho/dx;
cp=dt/rho/dx*gpuArray.ones(Nz,Nx,'single');
cc2=vp.*vp.*dt*dt/dx/dx;

p=gpuArray.zeros(Nz,Nx,'single');
p2=p;
p1=p;
p0=p;
vx=p;
vz=p;
vxx=p;
vxz=p;
vzx=p;
vzz=p;
px=p;
pz=p;
loc=gfloc(Nz,Nx,200,200);
loc=single(gpuArray(loc));
Nt=400;
wlet=gfwletricker(Nt,dt,30,40);
wlet=single(gpuArray(wlet));

% % Finite-difference for 2nd-order derivative. Pass test.
% Lxcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','Lx2');
% Lzcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','Lz2');
% Lxcuda.ThreadBlockSize=[32,32,1];
% Lxcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% Lzcuda.ThreadBlockSize=[32,32,1];
% Lzcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% p(:)=0;
% vx(:)=0;
% vz(:)=0;
% 
% disp('GPU finite-difference for 2nd-order derivative:');
% tic
% for it=1:Nt
%     px=feval(Lxcuda,p1,px,Nz,Nx,cm);
%     pz=feval(Lzcuda,p1,pz,Nz,Nx,cm);
%     p2=2*p1-p0+cc2.*(px+pz)+loc*wlet(it);
%     p0=p1;
%     p1=p2;
% end
% toc


% %rotated staggered-grid finite-difference. Pass test! 
% rsgffdcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','rsgffd');
% rsgbfdcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','rsgbfd');
% 
% rsgffdcuda.ThreadBlockSize=[32,32,1];
% rsgffdcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% rsgbfdcuda.ThreadBlockSize=[32,32,1];
% rsgbfdcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% disp('CUDA Kernal rotated staggered-grid finite-difference:');

% tic
% for it=1:Nt
%     [px,pz]=feval(rsgbfdcuda,p,px,pz,Nz,Nx,cm);
%     vx=vx+0.5*cp.*(pz+px);
%     vz=vz+0.5*cp.*(pz-px);
%     
%     [vxx,vxz]=feval(rsgffdcuda,vx,vxx,vxz,Nz,Nx,cm);
%     [vzx,vzz]=feval(rsgffdcuda,vz,vzx,vzz,Nz,Nx,cm);
%     p=p+0.5*cc.*(vxz+vxx+vzz-vzx)+loc*wlet(it);
% end
% toc


% % Finite-difference. Pass test.
% Lxcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','Lx1');
% Lzcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','Lz1');
% Lxcuda.ThreadBlockSize=[32,32,1];
% Lxcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% Lzcuda.ThreadBlockSize=[32,32,1];
% Lzcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% p(:)=0;
% vx(:)=0;
% vz(:)=0;
% 
% disp('GPU staggered-grid finite-difference:');
% tic
% for it=1:Nt
%     px=feval(Lxcuda,p,px,Nz,Nx,cm);
%     pz=feval(Lzcuda,p,pz,Nz,Nx,cm);
%     
%     vx=vx+cp.*px;
%     vz=vz+cp.*pz;
%     px=feval(Lxcuda,vx,px,Nz,Nx,cm);
%     pz=feval(Lzcuda,vz,pz,Nz,Nx,cm);
%     p=p+cc.*(px+pz)+loc*wlet(it);
% 
% end
% toc


% % Staggered-grid finite-difference
% sbLxcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','sbLx');
% sfLxcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','sfLx');
% sbLzcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','sbLz');
% sfLzcuda=parallel.gpu.CUDAKernel('gfconvn.ptx','gfconvn.cu','sfLz');
% 
% update11=parallel.gpu.CUDAKernel('gfupdate.ptx','gfupdate.cu','update11s');
% update12s=parallel.gpu.CUDAKernel('gfupdate.ptx','gfupdate.cu','update12');
% 
% update11.ThreadBlockSize=[32,32,1];
% update11.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% update12s.ThreadBlockSize=[32,32,1];
% update12s.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% 
% sbLxcuda.ThreadBlockSize=[32,32,1];
% sbLxcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% sbLzcuda.ThreadBlockSize=[32,32,1];
% sbLzcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% sfLxcuda.ThreadBlockSize=[32,32,1];
% sfLxcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% 
% sfLzcuda.ThreadBlockSize=[32,32,1];
% sfLzcuda.GridSize=[ceil(Nz/32),ceil(Nx/32),1];
% p(:)=0;
% vx(:)=0;
% vz(:)=0;
% 
% disp('CUDA Kernal staggered-grid finite-difference:');
% tic
% for it=1:Nt
%     px=feval(sbLxcuda,p,px,Nz,Nx,cm);
%     pz=feval(sbLzcuda,p,pz,Nz,Nx,cm);
%     
%     vx=vx+cp.*px;
%     vz=vz+cp.*pz;
%     px=feval(sfLxcuda,vx,px,Nz,Nx,cm);
%     pz=feval(sfLzcuda,vz,pz,Nz,Nx,cm);
%     p=p+cc.*(px+pz)+loc*wlet(it);
% 
% end
% toc
