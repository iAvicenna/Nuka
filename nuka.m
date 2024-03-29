
function varargout=nuka(nuc_seqs,optional)
        

    if nargin<1
        error('This functions requires atleast 1 argument: nuc_seqs');
    elseif nargin>2
        error('This function accepts at most 2 arguments: nuc_seqs,optional');
    end
    
    script_path=mfilename('fullpath');
    ind=regexp(script_path,'/');
    if isempty(ind)
        ind=regexp(script_path,'\');
    end
    script_dir=script_path(1:ind(end));

    addpath([script_dir 'functs']);
        
    
    error_text1=['Nucleotide sequence can be a cell of strings, chars or a char', ...
        'array of maximum number of dimensions2. '];
    
    if isa(nuc_seqs,'char') && ndims(nuc_seqs)>2 
        error([error_text1 'You provided a char array of ' num2str(ndims(nuc_seqs))  'dimensions']); 
    elseif ~isa(nuc_seqs,'cell') && ~isa(nuc_seqs,'char')
        error([error_text1 'You provided a ' class(nuc_seqs)]);
    end
    
    if exist('optional','var') && ~isempty(optional) && ~isa(optional,'struct')
        error('Optional argument must be a struct');
    end
    
    [s1,~]=size(nuc_seqs);
    
    frames=zeros(1,length(s1));
    replace_non_agct=true;
    phreds=[];

    var_names={'frames','replace_non_agct','phreds'};
    var_types={'double','logical','cell'};
    
    cell_types={'double'};

    if exist('optional','var') && ~isempty(optional)

        [frames,replace_non_agct,phreds]=...
            parseOptionalInputs(var_names,var_types,cell_types,optional,...
                   frames,replace_non_agct,phreds);
    end
    
    
    
    if ~isa(frames,'double') || any(frames~=ceil(frames))
        error('Frames must be an integer scalar array.');
    end
    

    
    if isa(nuc_seqs,'cell')
        
       nuc_seqs=char(nuc_seqs);
        
    end
    
 
        

    [~,s2]=size(nuc_seqs);
    aa_seq_length=floor((s2)/3);


    if replace_non_agct
        nuc_seqs=replaceNonAGCT(nuc_seqs);
    end

    amino_seqs=computeAAwithHash(nuc_seqs,int32(frames));


    varargout{1}=amino_seqs;
    
    
    if exist('phreds','var') && ~isempty(phreds)


        aa_phred=averagePhred(phreds,frames);

        varargout{2}=aa_phred;
       
    end
    
    
    
end
