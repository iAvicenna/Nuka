# Nuka
This is a fast nucleotide to aminoacid sequence conversion using MATLAB and C.
The code employs a minimal hash function (which uniquely characterizes any triple 
combinations of letters drawn from A,G,C,T,N. The hash function is

<p align="center">
f(s)= mod(s(1) + s(2)*5 + s(3)*25,125)+1
</p>

If any codon has the letter N in it (for unidentified) it returns the result as #. 
Stop codons are shown as X. Prior to conversion, it checks the data for any other 
character than A,G,C,T,N,U and replaces them with N (to prevent hash collisions). The
correction part and computation of hash keys from sequence data is done in C. The
remaining part of the conversion is done and can be parallelized. 

The conversion can be achieved by calling

<p align="center">
nuka(nuc_seqs,options)
</p>

where nuc_seqs is either a cell of nucleotide sequences or a character matrix. Optional
arguements are

*frames:* As a vector array of integers 0,1,2 with the same length as the number of sequences
(Default is a 0 vector meaning it starts converting from the start of the sequence).

*num_threads:* number of threads (default 1) that should be used (parallel pool is started 
automatically if bigger than 1). 

*replace_non_agct:* If true it replaces any non A,G,C,T,N,U character by N and replaces U by T. 
Defauly value is true. If you are %100 percent sure that your sequences do not contain any such 
characters then setting this to false results in slight speed up. However if this options is false
and there are such characters than the code might turn in unpredictable results (due to hash collisions)
so *NOT* reccomended. 

You can set the options as a struct such as

<p align="center">
options1.num_threads=2;
nuka(nuc_seqs,options1)
</p>

or if you do not want to use options then simply go

<p align="center">
nuka(nuc_seqs)
<p>



# Requirements

Matlab(2018b), C. Speed testing function also requires nt2aa function from the bioinformatics toolbox. 

# Author
Sina Tureli
Nuka

# Licensing

This repository is
[Apache-licensed](https://github.com/bamos/densenet.pytorch/blob/master/LICENSE).
