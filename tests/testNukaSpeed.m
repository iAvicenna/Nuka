function testNukaSpeed()
    
    addpath('../');
    
    data=load('test_seqs.mat');
    seqs1=data.seqs1;
    seq_lens=cellfun(@(x)length(x),seqs1);
   
    for i=1:4
        seqs1=[seqs1,seqs1];
        seq_lens=[seq_lens,seq_lens];
    end
  
    size=length(seqs1);
    frames=zeros(1,size);
    
        
    fprintf('Converting %d sequences of mean length %d.\n',size,round(mean(seq_lens)));
    
    
     
    fprintf('Using nuka...');
    t0=clock;
    options1.frames=frames;
    a1=nuka(char(seqs1),options1);
    t1=clock;
    fprintf('It took %1.2d seconds.\n',etime(t1,t0));
    
    
    fprintf('Using nt2aa...');
    t0=clock;
    a1=nt2aa(seqs1);
    t1=clock;
    fprintf('It took %1.2d seconds.\n',etime(t1,t0));
end