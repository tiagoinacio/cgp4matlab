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
    %       connectionGenes      {array} array of connection genes
    %       parameters       {array} array of parameter genes
    %       parameters_by_index {array} array of parameters groupped by order
    %       programInputs           {array} array of input genes
    %       programOutputs          {array} array of output genes
    %       functionGenes        {array} array of function genes
    %
    %   Structure Methods:
    %       setConnectionGenes_ {private} create the connection genes array
    %       setFunctionGenes_   {private} create the function genes array
    %       setProgramInputs_      {private} create the input genes array
    %       setProgramOutputs_     {private} create the output genes array
    %       setParameters_  {private} create the parameter genes array

    properties (Access = public)
        connectionGenes
        parameters
        programInputs
        programOutputs
        functionGenes
    end

    methods (Access = public)

        function this = Structure(vararg)
            % Structure Constructor
            %
            %   Create multiples genes arrays according to each type of gene.
            %
            %   Input:
            %       programInputs            {integer} number of CGP inputs
            %       genes             {integer} number of genes in the genotype
            %       genes_per_node    {integer} number of genes per node
            %       connection_genes  {integer} number of connection genes per node
            %       computational_nodes  {integer} number of nodes (without programInputs and programOutputs)
            %       parameters        {integer} number of CGP parameters
            %

            this.setProgramInputs_(vararg.inputs);
            this.setConnectionGenes_(vararg.inputs, vararg.genes, vararg.genes_per_node, vararg.connection_genes);
            this.setParameters_(vararg.inputs, vararg.genes, vararg.genes_per_node, vararg.connection_genes, vararg.computational_nodes, vararg.parameters);
            this.setFunctionGenes_(vararg.genes, vararg.genes_per_node, vararg.inputs);
            this.setProgramOutputs_(vararg.inputs, vararg.genes, vararg.genes_per_node, vararg.computational_nodes);
        end
    end

    methods (Access = private)
        function setConnectionGenes_(this, programInputs, genes, genes_per_node, connection_genes)
            % setConnectionGenes_ Setup the connection genes array
            %
            %   Input:
            %       this              {Structure} instante of the class
            %       programInputs            {integer} number of CGP inputs
            %       genes             {integer} number of genes in the genotype
            %       genes_per_node    {integer} number of genes per node
            %       connection_genes  {integer} number of connection genes per node
            %       computational_nodes  {integer} number of nodes (without inputs and programOutputs)
            %       parameters        {integer} number of CGP parameters
            %
            %   Examples:
            %       structure.setupConnections_(2, 60, 6, 2)
            %       structure.setupConnections_(4, 60, 3, 2)

            this.connectionGenes = cell(connection_genes, 1);

            for i = 1:connection_genes
                this.connectionGenes{i} = sort([ ...
                    1:programInputs, ...
                    programInputs + i + 1 : ...
                    genes_per_node : ...
                    genes ...
                ]);
            end
        end

        function setFunctionGenes_(this, genes, genes_per_node, programInputs)
            % setFunctionGenes_ Setup the function genes array
            %
            %   Input:
            %       this           {Structure} instante of the class
            %       genes          {integer} number of genes in the genotype
            %       genes_per_node {integer} number of genes per node
            %       programInputs         {integer} number of CGP parameters
            %
            %   Examples:
            %       structure.setFunctionGenes_(60, 3, 2)
            %       structure.setFunctionGenes_(40, 6, 2)

            this.functionGenes = [ ...
                1:programInputs, ...
                programInputs + 1:genes_per_node:genes - 1 ...
            ];
        end

        function setProgramInputs_(this, programInputs)
            % setprogramInputs_ Setup the input genes array
            %
            %   Input:
            %       this   {Structure} instante of the class
            %       programInputs {integer} number of CGP inputs
            %
            %   Examples:
            %       structure.setProgramInputs_(4)
            %       structure.setProgramInputs_(2)

            this.programInputs = 1:programInputs;
        end

        function setProgramOutputs_(this, programInputs, genes, genes_per_node, computational_nodes)
            % setProgramOutputs_ Setup the output genes array
            %
            %   Input:
            %       this    {Structure} instante of the class
            %       programInputs            {integer} number of CGP inputs
            %       genes             {integer} number of genes in the genotype
            %       genes_per_node    {integer} number of genes per node
            %       computational_nodes  {integer} number of nodes (without programInputs and programOutputs)
            %
            %   Examples:
            %       structure.setProgramOutputs_(4)
            %       structure.setProgramOutputs_(2)

            this.programOutputs = genes - (genes - (programInputs + (genes_per_node * computational_nodes)) - 1):genes;
        end

        function setParameters_(this, programInputs, genes, genes_per_node, connection_genes, computational_nodes, parameters)
            % setParameters_ Setup the parameter genes array
            %
            %   Input:
            %       programInputs            {integer} number of CGP inputs
            %       genes             {integer} number of genes in the genotype
            %       genes_per_node    {integer} number of genes per node
            %       connection_genes  {integer} number of connection genes per node
            %       computational_nodes  {integer} number of nodes (without programInputs and programOutputs)
            %       parameters        {integer} number of CGP parameters
            %
            %   Examples:
            %       structure.setupParameters_(programInputs, genes, genes_per_node, connection_genes, computational_nodes, parameters)

            if parameters < 1
                return
            end

            this.parameters = zeros(parameters, parameters * computational_nodes / parameters);
            parameters_ = zeros();

            for j = 1:parameters
                parameters_ = [ ...
                    parameters_, ...
                    programInputs + connection_genes  + j + 1 : ...
                    genes_per_node : ...
                    genes ...
                ];

                vector = [ ...
                    this.parameters(j), ...
                    programInputs + connection_genes  + j + 1 : ...
                    genes_per_node : ...
                    genes ...
                ];

                this.parameters(j,:) = vector(2:end);
            end

            %parameters_ = sort(this.parameters(2:end));
        end
    end
end
