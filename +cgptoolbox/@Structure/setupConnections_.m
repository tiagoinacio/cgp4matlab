function setupConnections_(this, INPUTS, GENES, GENES_PER_NODE, CONNECTION_GENES)
    % setupConnections_ Setup the connection genes array
    %
    %   Input:
    %       this              {Structure} instante of the class
    %       INPUTS            {integer} number of CGP inputs
    %       GENES             {integer} number of genes in the genotype
    %       GENES_PER_NODE    {integer} number of genes per node
    %       CONNECTION_GENES  {integer} number of connection genes per node
    %       CONNECTION_NODES  {integer} number of nodes (without inputs and outputs)
    %       PARAMETERS        {integer} number of CGP parameters
    %
    %   Examples:
    %       structure.setupConnections_(2, 60, 6, 2)
    %       structure.setupConnections_(4, 60, 3, 2)

    this.CONNECTIONS = cell(CONNECTION_GENES, 1);

    for i = 1:CONNECTION_GENES
        this.CONNECTIONS{i} = sort([ ...
            this.INPUTS, ...
            INPUTS + i + 1 : ...
            GENES_PER_NODE : ...
            GENES ...
        ]);
    end
end
