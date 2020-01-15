copyfile([matlabroot '\extern\examples\mex\yprime.c']);
mex yprime.c;
yprime(1, 1:4)