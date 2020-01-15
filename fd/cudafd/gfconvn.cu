#include <cuda.h>

/*Lx2Cuda performs the 2-D convolution of matrices A and row vector B*/
__global__ void Lx2(const float *d_in,float *d_out,int numRows,int numCols, float *mask)
{

    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
    // each thread computes one elements 
    if ((4<Row) && (Row<numRows-5) && (4<Col) && (Col<numCols-5)){
        d_out[Col*numRows+Row]=mask[0]*d_in[Col*numRows+Row]+
                mask[1]*(d_in[(Col-1)*numRows+Row]+d_in[(Col+1)*numRows+Row])+
                mask[2]*(d_in[(Col-2)*numRows+Row]+d_in[(Col+2)*numRows+Row])+
                mask[3]*(d_in[(Col-3)*numRows+Row]+d_in[(Col+3)*numRows+Row])+
                mask[4]*(d_in[(Col-4)*numRows+Row]+d_in[(Col+4)*numRows+Row])+
                mask[5]*(d_in[(Col-5)*numRows+Row]+d_in[(Col+5)*numRows+Row]);
    }
}

/*Lz2 performs the 2-D convolution of matrices A and column vector B*/
__global__ void Lz2(const float *d_in,float *d_out,int numRows,int numCols, float *mask)
{

    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
   
    // each thread computes one elements 
    if ((4<Row) && (Row<numRows-5) && (4<Col) && (Col<numCols-5)){
        int Loc = Col*numRows+Row;
        d_out[Loc]=mask[0]*d_in[Loc]+
                mask[1]*(d_in[Loc-1]+d_in[Loc+1])+
                mask[2]*(d_in[Loc-2]+d_in[Loc+2])+
                mask[3]*(d_in[Loc-3]+d_in[Loc+3])+
                mask[4]*(d_in[Loc-4]+d_in[Loc+4])+
                mask[5]*(d_in[Loc-5]+d_in[Loc+5]);
    }
}

/*Lz1 performs the 2-D convolution of matrices A and column vector C1*/
__global__ void Lz1(const float *d_in,float *d_out, int numRows,int numCols, float *mask)
{

    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
    // each thread computes one elements 
    if ((5<Row) && (Row<numRows-6) && (5<Col) && (Col<numCols-6)){
        int Loc = Col*numRows+Row;
        d_out[Loc]=
                mask[0]*(d_in[Loc+1]-d_in[Loc-1])+
                mask[1]*(d_in[Loc+2]-d_in[Loc-2])+
                mask[2]*(d_in[Loc+3]-d_in[Loc-3])+
                mask[3]*(d_in[Loc+4]-d_in[Loc-4])+
                mask[4]*(d_in[Loc+5]-d_in[Loc-5])+
                mask[5]*(d_in[Loc+6]-d_in[Loc-6]);
    }
}

/*Lx1 performs the 2-D convolution of matrices A and row vector C1*/
__global__ void Lx1(const float *d_in,float *d_out, int numRows,int numCols, float *mask)
{

    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
    // each thread computes one elements 
    if ((5<Row) && (Row<numRows-6) && (5<Col) && (Col<numCols-6)){
        d_out[Col*numRows+Row]=
                mask[0]*(d_in[(Col+1)*numRows+Row]-d_in[(Col-1)*numRows+Row])+
                mask[1]*(d_in[(Col+2)*numRows+Row]-d_in[(Col-2)*numRows+Row])+
                mask[2]*(d_in[(Col+3)*numRows+Row]-d_in[(Col-3)*numRows+Row])+
                mask[3]*(d_in[(Col+4)*numRows+Row]-d_in[(Col-4)*numRows+Row])+
                mask[4]*(d_in[(Col+5)*numRows+Row]-d_in[(Col-5)*numRows+Row])+
                mask[5]*(d_in[(Col+6)*numRows+Row]-d_in[(Col-6)*numRows+Row]);
    }

}

/*sbLx performs the 2-D convolution of matrices A and row vector S1*/
__global__ void sbLx(const float *d_in,float *d_out, int numRows,int numCols, float *mask)
{

    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
    // each thread computes one elements 
    if ((5<Row) && (Row<numRows-6) && (5<Col) && (Col<numCols-6)){
        d_out[Col*numRows+Row]=
                mask[0]*(d_in[(Col+1)*numRows+Row]-d_in[(Col-0)*numRows+Row])+
                mask[1]*(d_in[(Col+2)*numRows+Row]-d_in[(Col-1)*numRows+Row])+
                mask[2]*(d_in[(Col+3)*numRows+Row]-d_in[(Col-2)*numRows+Row])+
                mask[3]*(d_in[(Col+4)*numRows+Row]-d_in[(Col-3)*numRows+Row])+
                mask[4]*(d_in[(Col+5)*numRows+Row]-d_in[(Col-4)*numRows+Row])+
                mask[5]*(d_in[(Col+6)*numRows+Row]+d_in[(Col-5)*numRows+Row]);
    }

}

/*sfLx performs the 2-D convolution of matrices A and row vector S1*/
__global__ void sfLx(const float *d_in,float *d_out, int numRows,int numCols, float *mask)
{

    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
    // each thread computes one elements 
    if ((5<Row) && (Row<numRows-6) && (5<Col) && (Col<numCols-6)){
        d_out[Col*numRows+Row]=
                mask[0]*(d_in[(Col+0)*numRows+Row]-d_in[(Col-1)*numRows+Row])+
                mask[1]*(d_in[(Col+1)*numRows+Row]-d_in[(Col-2)*numRows+Row])+
                mask[2]*(d_in[(Col+2)*numRows+Row]-d_in[(Col-3)*numRows+Row])+
                mask[3]*(d_in[(Col+3)*numRows+Row]-d_in[(Col-4)*numRows+Row])+
                mask[4]*(d_in[(Col+4)*numRows+Row]-d_in[(Col-5)*numRows+Row])+
                mask[5]*(d_in[(Col+5)*numRows+Row]+d_in[(Col-6)*numRows+Row]);
    }
}
/*sbLz performs the 2-D convolution of matrices A and column vector S1*/
__global__ void sbLz(const float *d_in,float *d_out, int numRows,int numCols, float *mask)
{

    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;

    // each thread computes one elements 
    if ((5<Row) && (Row<numRows-6) && (5<Col) && (Col<numCols-6)){
        int Loc = Col*numRows+Row;
        d_out[Col*numRows+Row]=
                mask[0]*(d_in[Loc+1]-d_in[Loc-0])+
                mask[1]*(d_in[Loc+2]-d_in[Loc-1])+
                mask[2]*(d_in[Loc+3]-d_in[Loc-2])+
                mask[3]*(d_in[Loc+4]-d_in[Loc-3])+
                mask[4]*(d_in[Loc+5]-d_in[Loc-4])+
                mask[5]*(d_in[Loc+6]+d_in[Loc-5]);
    }

}
/*sfLz performs the 2-D convolution of matrices A and column vector S1*/
__global__ void sfLz(const float *d_in,float *d_out, int numRows,int numCols, float *mask)
{

    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
    // each thread computes one elements 
    if ((5<Row) && (Row<numRows-6) && (5<Col) && (Col<numCols-6)){
        int Loc = Col*numRows+Row;
        d_out[Loc]=
                mask[0]*(d_in[Loc+0]-d_in[Loc-1])+
                mask[1]*(d_in[Loc+1]-d_in[Loc-2])+
                mask[2]*(d_in[Loc+2]-d_in[Loc-3])+
                mask[3]*(d_in[Loc+3]-d_in[Loc-4])+
                mask[4]*(d_in[Loc+4]-d_in[Loc-5])+
                mask[5]*(d_in[Loc+5]+d_in[Loc-6]);
    }

}
/*rsgffd performs the 2-D forward rotated staggered-grid finite difference*/
__global__ void rsgffd(const float *d_in,float *d_outx,float *d_outz,const int numRows,int numCols,float *mask)
{
    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
    // each thread computes one elements 
    if ((5<Row) && (Row<numRows-6) && (5<Col) && (Col<numCols-6)){

        d_outx[Col*numRows+Row]=
                    mask[0]*(d_in[(Col+1)*numRows+Row-0]-d_in[(Col-0)*numRows+Row+1])+
                    mask[1]*(d_in[(Col+2)*numRows+Row-1]-d_in[(Col-1)*numRows+Row+2])+
                    mask[2]*(d_in[(Col+3)*numRows+Row-2]-d_in[(Col-2)*numRows+Row+3])+
                    mask[3]*(d_in[(Col+4)*numRows+Row-3]-d_in[(Col-3)*numRows+Row+4])+
                    mask[4]*(d_in[(Col+5)*numRows+Row-4]-d_in[(Col-4)*numRows+Row+5])+
                    mask[5]*(d_in[(Col+6)*numRows+Row-5]-d_in[(Col-5)*numRows+Row+6]);
        d_outz[Col*numRows+Row]=
                    mask[0]*(d_in[(Col+1)*numRows+Row+1]-d_in[(Col-0)*numRows+Row-0])+
                    mask[1]*(d_in[(Col+2)*numRows+Row+2]-d_in[(Col-1)*numRows+Row-1])+
                    mask[2]*(d_in[(Col+3)*numRows+Row+3]-d_in[(Col-2)*numRows+Row-2])+
                    mask[3]*(d_in[(Col+4)*numRows+Row+4]-d_in[(Col-3)*numRows+Row-3])+
                    mask[4]*(d_in[(Col+5)*numRows+Row+5]-d_in[(Col-4)*numRows+Row-4])+
                    mask[5]*(d_in[(Col+6)*numRows+Row+6]-d_in[(Col-5)*numRows+Row-5]);
    }
}

/*rsgbfd performs the 2-D backward rotated staggered-grid finite difference*/
__global__ void rsgbfd(const float *d_in,float *d_outx,float *d_outz,int numRows,int numCols,float *mask)
{
    //Calculate the row # of the d_in and d_out element to process
    int Col = blockIdx.y*blockDim.y + threadIdx.y;
    
    //Calculate the column # of the d_in and d_out element to process
    int Row = blockIdx.x*blockDim.x + threadIdx.x;
    
    // each thread computes one elements 
    if ((5<Row) && (Row<numRows-6) && (5<Col) && (Col<numCols-6)){
        d_outx[Col*numRows+Row]= 
                    mask[0]*(d_in[(Col+0)*numRows+Row-1]-d_in[(Col-1)*numRows+Row+0])+
                    mask[1]*(d_in[(Col+1)*numRows+Row-2]-d_in[(Col-2)*numRows+Row+1])+
                    mask[2]*(d_in[(Col+2)*numRows+Row-3]-d_in[(Col-3)*numRows+Row+2])+
                    mask[3]*(d_in[(Col+3)*numRows+Row-4]-d_in[(Col-4)*numRows+Row+3])+
                    mask[4]*(d_in[(Col+4)*numRows+Row-5]-d_in[(Col-5)*numRows+Row+4])+
                    mask[5]*(d_in[(Col+5)*numRows+Row-6]-d_in[(Col-6)*numRows+Row+5]);
        d_outz[Col*numRows+Row]= 
                    mask[0]*(d_in[(Col+0)*numRows+Row+0]-d_in[(Col-1)*numRows+Row-1])+
                    mask[1]*(d_in[(Col+1)*numRows+Row+1]-d_in[(Col-2)*numRows+Row-2])+
                    mask[2]*(d_in[(Col+2)*numRows+Row+2]-d_in[(Col-3)*numRows+Row-3])+
                    mask[3]*(d_in[(Col+3)*numRows+Row+3]-d_in[(Col-4)*numRows+Row-4])+
                    mask[4]*(d_in[(Col+4)*numRows+Row+4]-d_in[(Col-5)*numRows+Row-5])+
                    mask[5]*(d_in[(Col+5)*numRows+Row+5]-d_in[(Col-6)*numRows+Row-6]);
    }
}




