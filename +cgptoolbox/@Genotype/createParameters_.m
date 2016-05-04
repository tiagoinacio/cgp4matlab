function createParameters_(this, SIZE, parameters)
    % createParameters_ create the CGP parameters
    %
    %   If the CGP was configured with parameters,
    %   one must add them to each node of the genotype.
    %   So, each node should have:
    %       function gene
    %       connection genes
    %       parameters genes
    %   One should get the parameter value from the function handle
    %   provided at configuration time.
    %
    %   Input:
    %       this {Genotype} instante of the class
    %           genes_ {array} array of genes of the genotype
    %       SIZE {struct} struct with size related constants
    %       parameters {array} array of structs with 3 fields each:
    %           'name'       {string} the name of the parameter
    %           'initialize' {Handle} function handle which returns the parameter value
    %           'mutate'     {Handle} function handle to mutate the parameter value
    %
    %   Examples:
    %       genotype.createParameters_(struct(
    %           'INPUTS', 4,
    %           'GENES', 101,
    %           'GENES_PER_NODE', 6,
    %           'PARAMETERS', 3
    %       ));
    %
    %       genotype.createParameters_(struct(
    %           'INPUTS', 2,
    %           'GENES', 80,
    %           'GENES_PER_NODE', 4,
    %           'PARAMETERS', 1
    %       ));

    if SIZE.PARAMETERS > 0
        for i = SIZE.INPUTS + 4:SIZE.GENES_PER_NODE:SIZE.GENES
            for indexOfParameter = 1:SIZE.PARAMETERS
                this.genes_(i + indexOfParameter - 1) = parameters{indexOfParameter}.initialize();
            end
        end
    end
end
