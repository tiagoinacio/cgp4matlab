function setupParameters_(this, INPUTS, GENES, GENES_PER_NODE, CONNECTION_GENES, CONNECTION_NODES, PARAMETERS)
    % setupParameters_ Setup the parameter genes array
    %
    %   Input:
    %       INPUTS            {integer} number of CGP inputs
    %       GENES             {integer} number of genes in the genotype
    %       GENES_PER_NODE    {integer} number of genes per node
    %       CONNECTION_GENES  {integer} number of connection genes per node
    %       CONNECTION_NODES  {integer} number of nodes (without inputs and outputs)
    %       PARAMETERS        {integer} number of CGP parameters
    %
    %   Examples:
    %       structure.setupParameters_(INPUTS, GENES, GENES_PER_NODE, CONNECTION_GENES, CONNECTION_NODES, PARAMETERS)

    if PARAMETERS < 1
        return
    end

    this.PARAMETERS_ORDER = zeros(PARAMETERS, PARAMETERS * CONNECTION_NODES / PARAMETERS);
    this.PARAMETERS = zeros();

    for j = 1:PARAMETERS
        this.PARAMETERS = [ ...
            this.PARAMETERS, ...
            INPUTS + CONNECTION_GENES  + j + 1 : ...
            GENES_PER_NODE : ...
            GENES ...
        ];

        vector = [ ...
            this.PARAMETERS_ORDER(j), ...
            INPUTS + CONNECTION_GENES  + j + 1 : ...
            GENES_PER_NODE : ...
            GENES ...
        ];

        this.PARAMETERS_ORDER(j,:) = vector(2:end);
    end

    this.PARAMETERS = sort(this.PARAMETERS(2:end));
end
