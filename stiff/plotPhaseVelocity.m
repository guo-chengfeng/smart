vp=3500;
vs=1500;
epsilon=0;
delta=0;
gama=0;
rho=2000;
theta=0;
phi=0;
[c11,c13,c33,c44,c66]=gftho2elp(vp,vs,epsilon,gama,delta,rho);
c12=c11-2*c44;
CVTI=[c11   c12   c13   0   0   0;
      c12   c11   c13   0   0   0;
      c13   c13   c33   0   0   0;
       0     0     0   c44  0   0;
       0     0     0    0  c44  0;
       0     0     0    0   0 c66];
 CTTI=gfttic3d(CVTI,theta,phi);
 
 figure();
 k=0;
 gfsolveChristoffel(CTTI,rho,k)
 title('P-wave');
 
 figure();
 k=1;
 gfsolveChristoffel(CTTI,rho,k)
 title('SV-wave');
 
 figure();
 k=2;
 gfsolveChristoffel(CTTI,rho,k)
 title('SH-wave');
 
 
 
   