function varargout=parseOptionalInputs(var_names,var_types,cell_types,optional,varargin)

    if nargin-length(varargin)<4
        error('This function needs 4 inputs other than the last variable size input');
    end

    
        %out = inputname(1);

    
    if ~isa(var_names,'cell') || ~isa(var_types,'cell')
        error('First and second inputs must be of cell type.');
    end
    
    if ~isa(optional,'struct')
        error('Fourth input must be a structure');
    end
    
    
    
    field_names=fieldnames(optional);

   
    
    s1=length(var_names);
    s2=length(var_types);
    s3=length(field_names);
    s4=length(varargin);
    if s1~= s2
        error('First and second inputs should have the same length');
    end
    
    if s4~= s2
        error('Last group of arguments after optional should have the same number of elements as first and second inputs.');
    end
    

    field_names=fieldnames(optional);
    k=1;
    found=0;
    
    
    for i=1:s3
        found=0;
        m=0;
        for j=1:s1
            
            if strcmp(var_types{j},'cell')
                m=m+1;
            end
            
            if strcmp(field_names{i},var_names{j})
                varargin{j}=getfield(optional,field_names{i}); 
                if ~isempty(varargin{j}) && ~isa(varargin{j},var_types{j})
                    error([var_names{j} ' field in the optional input should be a ' var_types{j}]);
                elseif strcmp(var_types{j},'cell') 
                    if ~isempty(cell_types{m}) && ~isempty(varargin{j}) && ~all(cellfun(@(x)isa(x,cell_types{m}),varargin{j})==1)
                        error(['The cell ' var_names{j} ' field in the optional input should only contain ' cell_types{m}]);
                    end
                end
                
                found=1;
                k=k+1;
                  
            end
        end
        
        if found==0
           error('Unknown field %s in optional input.',field_names{i});
        end
    end
    
    varargout=cell(1,length(varargin));
         
    for i=1:length(varargin)
        varargout{i}=varargin{i};
    end
    

end