function setupOutputs_(this, INPUTS, GENES, GENES_PER_NODE, CONNECTION_NODES)
    % setupOutputs_ Setup the output genes array
    %
    %   Input:
    %       this    {Structure} instante of the class
    %       INPUTS            {integer} number of CGP inputs
    %       GENES             {integer} number of genes in the genotype
    %       GENES_PER_NODE    {integer} number of genes per node
    %       CONNECTION_NODES  {integer} number of nodes (without inputs and outputs)
    %
    %   Examples:
    %       structure.setupOutputs_(4)
    %       structure.setupOutputs_(2)

    this.OUTPUTS = GENES - (GENES - (INPUTS + (GENES_PER_NODE * CONNECTION_NODES)) - 1):GENES;
end
