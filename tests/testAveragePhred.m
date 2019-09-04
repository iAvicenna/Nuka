function [test_name,isFailed]=testAveragePhred(failSwitch)

    addpath('../');
    
    isFailed=0;
    test_name='testAvargePhred';

    if nargin<1
        error('Requires the failSwitch argument');
    end
   
    phred{1}=[1 2 3 3 2 1 3 2 1];
    phred{2}=[2 3 1 4 1 3 4 5 1];
    phred{3}=[2 4];
    phred{4}=[];
    
    phred2=[1 2 3 3 2 1 3 2 1;2 3 1 4 1 3 4 5 1;2 4 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0;];
    
    result= [2,2,2;2,8/3,10/3;0,0,0;0,0,0];
    
    if failSwitch
        phred{1}(1)=2;
    end
    
    frames(1)=0;
    frames(2)=1;
    frames(3)=0;
    frames(4)=0;
    
    aa_phred=averagePhred(phred,frames);
    aa_phred2=averagePhred(phred2,frames);
     
    if sum(aa_phred(:) ~= result(:))~=0 || sum(aa_phred2(:) ~= result(:))~=0
        isFailed=1;
    end
    
end