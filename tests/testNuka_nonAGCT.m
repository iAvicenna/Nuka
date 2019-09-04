function [test_name,isFailed]=testNuka_nonAGCT(failSwitch)

    if nargin<1
        error('Requires the failSwitch argument');
    end
    
    isFailed=0;
    test_name='testNuka_nonAGCT';
    addpath('../');
    
    seqs{1}='ANCTGTCGTGTC';
    seqs{2}='A;CTGTCGTGTC';
    seqs{3}='ANCTGUCGTGTC';
    if failSwitch==1
        options1.replace_non_agct=false;
    end
   

    options1.frames=zeros(1,3);
    a1=nuka(seqs,options1);

    if any(a1(1,:)~=a1(2,:)) || any(a1(1,:)~=a1(3,:))
        isFailed=1;
    end
        
      


end