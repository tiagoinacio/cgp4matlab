classdef Structure < handle
    % Structure Class
    %   Class with array of genes structured by type
    %
    %   This class should provide an helper for the CGP program.
    %   Each propertie is identified by the type of genes that it stores.
    %   The genotype is an array of genes, but there are no distinction
    %   between the function genes, or connection genes, etc. This
    %   properties should provided a basic mapping between the gene index
    %   and the propertie that it represents.
    %
    %   Structure Properties:
    %       CONNECTIONS      {array} array of connection genes
    %       PARAMETERS       {array} array of parameter genes
    %       PARAMETERS_ORDER {array} array of parameters groupped by order
    %       INPUTS           {array} array of input genes
    %       OUTPUTS          {array} array of output genes
    %       FUNCTIONS        {array} array of function genes
    %
    %   Structure Methods:
    %       setupConnections_ {private} create the connection genes array
    %       setupFunctions_   {private} create the function genes array
    %       setupInputs_      {private} create the input genes array
    %       setupOutputs_     {private} create the output genes array
    %       setupParameters_  {private} create the parameter genes array

    properties (Access = public)
        CONNECTIONS
        PARAMETERS
        PARAMETERS_ORDER
        INPUTS
        OUTPUTS
        FUNCTIONS
    end

    methods (Access = public)

        function this = Structure( ...
            INPUTS,                ...
            GENES,                 ...
            GENES_PER_NODE,        ...
            CONNECTION_GENES,      ...
            CONNECTION_NODES,      ...
            PARAMETERS             ...
        )
            % Structure Constructor
            %
            %   Create multiples genes arrays according to each type of gene.
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
            %       Genotype(INPUTS, GENES, GENES_PER_NODE, CONNECTION_GENES, CONNECTION_NODES, PARAMETERS)

            this.setupInputs_(INPUTS);
            this.setupConnections_(INPUTS, GENES, GENES_PER_NODE, CONNECTION_GENES);
            this.setupParameters_(INPUTS, GENES, GENES_PER_NODE, CONNECTION_GENES, CONNECTION_NODES, PARAMETERS);
            this.setupFunctions_(GENES, GENES_PER_NODE, INPUTS);
            this.setupOutputs_(INPUTS, GENES, GENES_PER_NODE, CONNECTION_NODES);
        end

    end
end
