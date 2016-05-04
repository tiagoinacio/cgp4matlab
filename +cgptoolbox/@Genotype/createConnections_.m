function createConnections_(this, SIZE)
    % createConnections_ create connections for a given node
    %
    %   Randomly select possible node connections, for a given node.
    %
    %   Input:
    %       this {Genotype} instante of the class
    %           genes_ {array} array of genes of the genotype
    %
    %       SIZE {struct} structure with size related constants
    %           'INPUTS'           {integer} - the number of CGP inputs
    %           'CONNECTION_GENES' {integer} - the number of connection genes for each node
    %           'GENES_PER_NODE'   {integer} - the number of genes per node
    %           'OUTPUTS'          {integer} - the number of CGP outputs
    %
    %   Examples:
    %       genotype.createConnections_(struct(
    %           'INPUTS', 4,
    %           'CONNECTION_GENES', 2,
    %           'GENES_PER_NODE', 6,
    %           'OUTPUTS', 1
    %       ))
    %
    %       genotype.createConnections_(struct(
    %           'INPUTS', 2,
    %           'CONNECTION_GENES', 3,
    %           'GENES_PER_NODE', 8,
    %           'OUTPUTS', 2
    %       ))

    for i = SIZE.INPUTS + 1:SIZE.GENES_PER_NODE:SIZE.GENES - SIZE.OUTPUTS
        for j = 1:SIZE.CONNECTION_GENES
            this.genes_(i + j) = cgptoolbox.Connection(SIZE, i).get();
        end
    end
end
