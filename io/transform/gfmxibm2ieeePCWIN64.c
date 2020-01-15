#include <uchar.h>
#include "mex.h"
/* This is the Mex-Code to replace the ibm2ieee and ieee2ibm for efficiency
 *   Version: V1.0
 *   Author : C.F.Guo
 *   Time   : 2015/9/11 
 */

void IEEEtoIBM32 ( void *uptr, int sw , long m)
{
	unsigned char *cp, cExp, c, cSign;
	unsigned int *ulp, ulExp;
	long i;
	int *lp; int shift,  k; float *fp;
	if ( sw == 5|| sw == 6) return;
	cp= ( unsigned char* ) uptr;
	if ( sw == 3){
		for( i= 0; i< m; i++ )
		{ c= cp[ 0] ; cp[ 0] = cp[ 1] ; cp[ 1] = c; cp+= 2; }
		return;
	}
	else if( sw == 4){
		for( i= 0; i< m; i++ ){
			c= cp[ 0] ; cp[ 0] = cp[ 3] ; cp[ 3] = c;
			c= cp[ 1] ; cp[ 1] = cp[ 2] ; cp[ 2] = c;
			cp+= 4;}
		return;
	}

	fp= ( float * ) uptr;
	for ( i= 0; i< m; i++ , fp++ ){
		cp= ( unsigned char* ) fp;
		ulp= ( unsigned int * ) fp;
		lp= ( int * ) fp; cExp= * lp>> 24;
		cSign = cExp & 0x80;
		cExp= ( * lp<< 1) >> 24;
		k= cExp- 127; cExp-= 127;
		shift= 4- k% 4; k= k/ 4+ 1;
		* lp<<= 9; * lp>>= 1;
		* lp= * lp| 0x80000000;
		cExp= k+ 64;
		* ulp>>= ( 8+ shift- 1) ;
		ulExp= cExp; ulExp<<= 24;
		if ( cSign)
			* ulp= ulExp| * lp| 0x80000000;
		else
			* ulp= ulExp| * lp;
		if( sw == 8){
			c= cp[ 0] ; cp[ 0] = cp[ 3] ; cp[ 3] = c;
			c= cp[ 1] ; cp[ 1] = cp[ 2] ; cp[ 2] = c;}
	}
}


void IBM32toIEEE ( void *uptr, int sw , long m)
{
    unsigned char * cp, cExp, c, cSign;
    unsigned int * ulp, ulExp;
    int * lp;
    int shift;
    long i;
    float * fp;
    if ( sw == 5|| sw == 6) return;
    cp= ( unsigned char * ) uptr;
    if ( sw == 3){
        for( i= 0; i< m; i++ ){
            c= cp[ 0] ; cp[ 0] = cp[ 1] ; cp[ 1] = c; cp+= 2;}
        return;
    }
    else if( sw == 4){
        for( i= 0; i< m; i++ ){
            c= cp[ 0] ; cp[ 0] = cp[ 3] ; cp[ 3] = c;
            c= cp[ 1] ; cp[ 1] = cp[ 2] ; cp[ 2] = c;
            cp+= 4;    }
        return;
    }

    fp= ( float * ) uptr;
    for ( i= 0; i< m; i++ , fp++ ){
        cp= ( unsigned char* ) fp;
        ulp= ( unsigned int* ) fp;
        lp= ( int* ) fp;
        if ( sw == 8){
            c= cp[ 0] ; cp[ 0] = cp[ 3] ; cp[ 3] = c;
            c= cp[ 1] ; cp[ 1] = cp[ 2] ; cp[ 2] = c;}
        cExp= * lp>> 24;
        * lp<<= 8; shift= 1;
        while( (*lp>0) & (shift<23))
        { * lp<<= 1; shift++ ; }
        * lp<<= 1; cSign = cExp & 0x80;
        cExp &= 0x7f ;
        if ( cExp!= 0){
            cExp-= 64; * ulp>>= 9;
            ulExp= 0x7f+ ( cExp* 4- shift ) ;
            ulExp<<= 23;
            if ( cSign)
                * ulp= ulExp | * lp | 0x80000000;
            else
                * ulp= ulExp | * lp;}
    }
}

void mexFunction(int nlhs, mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
    float *dat; 
    float *indat;
    
    int im,in;
    int mrows,ncols,mn;
    int index;
    mrows = mxGetM(prhs[0]);
    ncols = mxGetN(prhs[0]);
    int ndim=mxGetNumberOfDimensions(prhs[0]);
    int dims[2]={mrows,ncols};
    
    mn=mrows*ncols;
    plhs[0]= mxCreateNumericArray(ndim,dims,mxSINGLE_CLASS,mxREAL);
    
    dat= (float *)mxGetPr(plhs[0]);
    indat= (float *)mxGetPr(prhs[0]);
    
  /* for(im=0;im<mrows;im++)
   {
       dims[0]=im;
    for(in=0;in<ncols;in++){
       dims[1]=in;
       index=mxCalcSingleSubscript(prhs[0],ndim,dims);
       mexPrintf("Index= %d  Val=%g \n",index,indat[index]);}
   }*/
    for(im=0;im<mrows;im++)
        for(in=0;in<ncols;in++)
        dat[in*mrows+im]=indat[in*mrows+im];
        
    IBM32toIEEE(dat,7,mn);
}
