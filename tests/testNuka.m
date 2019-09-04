function [test_name,isFailed]=testNuka(failSwitch)

    if nargin<1
        error('Requires the failSwitch argument');
    end
    test_name='testNuka';
    isFailed=0;
    addpath('../');
    
    
    letters={'A','G','C','T'};
    letters_fail={'G','A','T','C'};
    for k=1:10
        N=100;

        fr_ind=randi(3)-1;

        for i=1:N

            length=randi(100)+10;
            frames(i)=fr_ind;

            for j=1:length
                ind=randi(4);
                seqs1(i,j)=letters{ind};
                seqs2{i}(j)=letters{ind};
                if failSwitch==1
                    seqs2{i}(j)=letters_fail{ind};
                end
                    
            end
        end


        options1.frames=frames;
        a1=nuka(seqs1,options1);
        a2=nuka(seqs2,options1);      
        a3=char(nt2aa(seqs2,'frame',fr_ind+1));
        
      

        if all(isspace(a1(:,end)))
            a1=a1(:,1:end-1);
        end
        
        if all(isspace(a2(:,end)))
            a2=a2(:,1:end-1);
        end

        a3(a3=='*')='X';


        if any(a1(:)~=a2(:)) || any(a1(:)~=a3(:))

            if(~(all(a1(a1(:)~=a3(:))=='L') && all(a3(a1(:)~=a3(:))=='M'))) %Remark there is a bug in nt2aa, it thinksCTG is M but it is L
                isFailed=1;
            end

        end
        
        if isFailed
            break;
        end
        
    end
    
    
    seqs3{1}='GTCNGT';
    seqs3{2}='GTCNNT';
    seqs3{3}='GTCNNN';
    seqs3{4}='GTCNTN';
    seqs3{5}='GTCTNN';
    
    
    options1.frames=ones(1,5)-1;
    a1=nuka(seqs3,options1);
    
    for i=1:5
        if strcmp(a1(i,:),'V#')==0
            isFailed=1;
        end
    end
    
    options1.frames=ones(1,5);
    a2=nuka(seqs3,options1);
    
    for i=1:4
        if strcmp(a2(i,:),'# ')==0
            isFailed=1;
        end
    end
    
    if strcmp(a2(5,:),'S ')==0
        isFailed=1;
    end


end