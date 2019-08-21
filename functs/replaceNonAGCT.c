#include "mex.h"
#include "string.h"
#include "math.h"
#include "ctype.h"

  
void mexFunction(int nlhs,mxArray *plhs[ ],int nrhs,const mxArray *prhs[ ])   
{   

    if(nrhs!=1)   
        mexErrMsgTxt("1 input required.");   
    else if(nlhs>1)   
        mexErrMsgTxt("Too many output arguments.");
    
    if(mxIsChar(prhs[0])!=1)
        mexErrMsgTxt("Input 1 must be a char matrix.");
    
   
    mxChar* sequences;
 
    int i,j;

    int rows=mxGetM(prhs[0]);
    int cols=mxGetN(prhs[0]);
    
  
    int buflen1=(rows *cols);  

    
    sequences=mxCalloc(buflen1,sizeof(char));
   
    sequences=mxGetChars(prhs[0]);   
    
    const mwSize dims[2] = {rows,cols};
    plhs[0] = mxCreateCharArray(2,  dims);
    mxChar* corrected_sequences= (mxChar*)mxGetData(plhs[0]);
        
   
    #define sequences(i,j) sequences[i-1 + (j-1)*rows]
    #define corrected_sequences(i,j)  corrected_sequences[i-1 + (j-1)*rows]

    
    for (i=1;i<=rows;i++)
    {
        for (j=1;j<=cols;j++)
        {
            if (sequences(i,j)=='U')
            {
                corrected_sequences(i,j)='T';
            
            }
            else if (sequences(i,j)!='A' &&  sequences(i,j)!='G' &&  sequences(i,j)!='C' && sequences(i,j)!='T' && sequences(i,j) && !isspace(sequences(i,j)))
            {
                 corrected_sequences(i,j)='N';
                 
                    
            }   
            else
            {
                 corrected_sequences(i,j)=sequences(i,j);
            }
                
        }
                

    }
    
    
    
    return;
}