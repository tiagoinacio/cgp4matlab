function setupFunctions_(this, GENES, GENES_PER_NODE, INPUTS)
    % setupFunctions_ Setup the function genes array
    %
    %   Input:
    %       this           {Structure} instante of the class
    %       GENES          {integer} number of genes in the genotype
    %       GENES_PER_NODE {integer} number of genes per node
    %       INPUTS         {integer} number of CGP parameters
    %
    %   Examples:
    %       structure.setupFunctions_(60, 3, 2)
    %       structure.setupFunctions_(40, 6, 2)

    this.FUNCTIONS = [ ...
        this.INPUTS, INPUTS + 1:GENES_PER_NODE:GENES - 1 ...
    ];
end
