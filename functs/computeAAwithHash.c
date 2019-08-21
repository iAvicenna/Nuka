#include "mex.h"
#include "string.h"
#include "math.h"
#include "ctype.h"

  
char* initializeHashFunction()
{
    
    const mwSize dims[2] = {125};

    char* codon_hash=mxCalloc(125,sizeof(char));

    
    #define codon_hash(i) codon_hash[i-1]


    codon_hash(7)='A';
    codon_hash(82)='A';
    codon_hash(32)='A';
    codon_hash(57)='A';
    codon_hash(40)='C';
    codon_hash(115)='C';
    codon_hash(122)='D';
    codon_hash(72)='D';
    codon_hash(22)='E';
    codon_hash(47)='E';
    codon_hash(105)='F';
    codon_hash(55)='F';
    codon_hash(27)='G';
    codon_hash(102)='G';
    codon_hash(52)='G';
    codon_hash(77)='G';
    codon_hash(118)='H';
    codon_hash(68)='H';
    codon_hash(86)='I';
    codon_hash(36)='I';
    codon_hash(111)='I';
    codon_hash(16)='K';
    codon_hash(41)='K';
    codon_hash(5)='L';
    codon_hash(30)='L';
    codon_hash(88)='L';
    codon_hash(38)='L';
    codon_hash(113)='L';
    codon_hash(13)='L';
    codon_hash(11)='M';
    codon_hash(116)='N';
    codon_hash(66)='N';
    codon_hash(3)='P';
    codon_hash(78)='P';
    codon_hash(28)='P';
    codon_hash(53)='P';
    codon_hash(18)='Q';
    codon_hash(43)='Q';
    codon_hash(23)='R';
    codon_hash(98)='R';
    codon_hash(48)='R';
    codon_hash(73)='R';
    codon_hash(46)='R';
    codon_hash(71)='R';
    codon_hash(20)='S';
    codon_hash(95)='S';
    codon_hash(45)='S';
    codon_hash(70)='S';
    codon_hash(21)='S';
    codon_hash(96)='S';
    codon_hash(1)='T';
    codon_hash(76)='T';
    codon_hash(26)='T';
    codon_hash(51)='T';
    codon_hash(92)='V';
    codon_hash(42)='V';
    codon_hash(117)='V';
    codon_hash(17)='V';
    codon_hash(90)='W';
    codon_hash(35)='X';
    codon_hash(60)='X';
    codon_hash(65)='X';
    codon_hash(10)='Y';
    codon_hash(85)='Y';
    codon_hash(29)='#';
    codon_hash(81)='#';
    codon_hash(91)='#';
    codon_hash(79)='#';
    codon_hash(6)='#';
    codon_hash(101)='#';
    codon_hash(54)='#';
    codon_hash(106)='#';
    codon_hash(121)='#';
    codon_hash(4)='#';
    codon_hash(56)='#';
    codon_hash(61)='#';
    codon_hash(104)='#';
    codon_hash(31)='#';
    codon_hash(39)='#';
    codon_hash(83)='#';
    codon_hash(93)='#';
    codon_hash(89)='#';
    codon_hash(8)='#';
    codon_hash(103)='#';
    codon_hash(64)='#';
    codon_hash(108)='#';
    codon_hash(123)='#';
    codon_hash(14)='#';
    codon_hash(58)='#';
    codon_hash(63)='#';
    codon_hash(114)='#';
    codon_hash(33)='#';
    codon_hash(59)='#';
    codon_hash(87)='#';
    codon_hash(97)='#';
    codon_hash(109)='#';
    codon_hash(12)='#';
    codon_hash(107)='#';
    codon_hash(84)='#';
    codon_hash(112)='#';
    codon_hash(2)='#';
    codon_hash(34)='#';
    codon_hash(62)='#';
    codon_hash(67)='#';
    codon_hash(9)='#';
    codon_hash(37)='#';
    codon_hash(124)='#';
    codon_hash(100)='#';
    codon_hash(110)='#';
    codon_hash(49)='#';
    codon_hash(25)='#';
    codon_hash(120)='#';
    codon_hash(24)='#';
    codon_hash(125)='#';
    codon_hash(15)='#';
    codon_hash(99)='#';
    codon_hash(75)='#';
    codon_hash(80)='#';
    codon_hash(74)='#';
    codon_hash(50)='#';
    codon_hash(94)='#';
    codon_hash(19)='#';
    codon_hash(119)='#';
    codon_hash(69)='#';
    codon_hash(44)='#';
    
    return codon_hash;
    
}

void mexFunction(int nlhs,mxArray *plhs[ ],int nrhs,const mxArray *prhs[ ])   
{   

    
    if(nrhs!=2)   
        mexErrMsgTxt("2 inputs required.");   
    else if(nlhs>1)   
        mexErrMsgTxt("Too many output arguments.");
    
    if(mxIsChar(prhs[0])!=1)
        mexErrMsgTxt("Input 1 must be a char matrix.");
    
    if(mxIsInt32(prhs[1])!=1) 
        mexErrMsgTxt("Input 2 must be an integer array.");
    
    mxChar* sequences;
    int *frames;
    int i,j,k;
    k=1;
    
    int rows=mxGetM(prhs[0]);
    int cols=mxGetN(prhs[0]);
    
    
    int sz1=mxGetN(prhs[1]);
    
    if (sz1!=rows)
        mexErrMsgTxt("Number of rows for sequences and length of frames should be the same");
        
    
    frames=mxGetData(prhs[1]);
    
    int buflen1=(rows *cols);  

    
    sequences=mxCalloc(buflen1,sizeof(char));
   
    sequences=mxGetChars(prhs[0]);   
        
    int hash_size=floor(cols/3);
   

    /*output related variables */
    int * hash_keys = (int *) mxGetData(mxCreateNumericMatrix(rows,hash_size, mxINT32_CLASS, mxREAL));
    
    #define sequences(i,j) sequences[i-1 + (j-1)*rows]
    #define hash_keys(i,j) hash_keys[i-1 + (j-1)*rows]
    #define frames(i) frames[i-1]
    
    
    for (i=1;i<=rows;i++)
    {
        k=1;
        for (j=1+frames(i);j<=cols-2;j=j+3)
        {
            
            if((sequences(i,j+2))&&!isspace(sequences(i,j+2)))      
            {
                hash_keys(i,k)=((sequences(i,j))+(sequences(i,j+1))*5 + (sequences(i,j+2))*25)%125+1;
                k=k+1;
            }
            else
            {
                hash_keys(i,k)=-1;
                k=k+1;
            }   
                
        }

        if (hash_keys(i,hash_size)==0)
            hash_keys(i,hash_size)=-1;
                

    }
    
    
    //hash_key[0]=((sequences[0])+(sequences[1])*5 + (sequences[2])*25)%125+1;
    
    const mwSize dims[2] ={rows,hash_size};

    char* codon_hash=mxCalloc(125,sizeof(char));
    plhs[0]=mxCreateCharArray(2,dims);
    
   
    mxChar* amino_seqs= (mxChar*)mxGetData(plhs[0]);

    
    codon_hash=initializeHashFunction();
    
    #define codon_hash(i) codon_hash[i-1]
    #define amino_seqs(i,j) amino_seqs[i-1+rows*(j-1)]
    
    
    
    int ind=1;
    int hash_key;
    char aa;
    

    for (i=1;i<=rows;i++)
    {
        ind=1;
        for (j=1;j<=hash_size;j++)
        {
            hash_key=hash_keys(i,ind);
            
            if (hash_key==-1)
            {
               aa=' ';
            }
            else if (hash_key>123 || hash_key<1)
            {
                aa='?';
            }
            else
            {
                aa=codon_hash(hash_key);
            }
                    

            if (hash_key!=-1 && isspace(aa))
            {
                aa='?';
            }


            amino_seqs(i,ind)=aa;

            ind=ind+1;
            
        }
    }
    
 
    
    return;
}