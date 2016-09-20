classdef Genotype < handle
    % Genotype Class
    %   Instatiate a genotype
    %
    %   Create the input genes
    %   Create the function genes
    %   Create the connection genes
    %   Create the parameter genes
    %   Create the output genes
    %   Find which nodes are active and calculate the fitness of this genotype/solution.
    %
    %   Genotype Properties:
    %       activeNodes_  {array} arary of active nodes
    %       genes_   {array} array of genes
    %       fitness_ {Number} fitness value
    %
    %   Genotype Methods:
    %       active  {public} get the active genes
    %       fitness {public} get the fitness value
    %       genes   {public} get the genotype genes
    %
    %       createConnections_ {private} create the connection genes
    %       createFunctions_   {private} create the function genes
    %       createInputs_      {private} create the input genes
    %       createOutputs_     {private} create the output genes
    %       findActiveNodes_   {private} find which nodes are active

    properties (Access = private)
        activeNodes_
        genes_
        fitness_
    end

    methods (Access = public)

        function this = Genotype(vararg)
            % Genotype Constructor
            %
            %   Input:
            %       config     {struct} struct constant with configuration values
            %       sizes       {struct} sizes related struct constant
            %       structure  {Structure} struct constant with genes split into sections
            %       inputs     {Array} array of cgp inputs
            %       functions  {Array} array of functions from the function-set
            %       parameters {Array} array of parameters of the genotype
            %
            %   Examples:
            %       Genotype(config, sizes, structure, inputs, functions, parameters)

            this.genes_ = zeros(1, vararg.config.sizes.genes);

            this.createProgramInputs_(vararg.config.structure.programInputs);
            this.createFunctionGenes_(vararg.config.structure.functionGenes, vararg.config.sizes.functions, vararg.config.sizes.inputs);
            this.createConnectionGenes_(vararg.config.structure, vararg.config.sizes);
            this.createParameters_(vararg.config.sizes, vararg.parameters);
            this.createProgramOutputs_(vararg.config.sizes.inputs, vararg.config.sizes.genes, vararg.config.sizes.outputs, vararg.config.sizes.nodes, vararg.config.last_node_output);

            this.activeNodes_ = this.findActiveNodes_(vararg.config.sizes, vararg.config.structure.connectionGenes);

            this.fitness_ = cgptoolbox.Fitness(struct( ...
                'fitness_function', vararg.config.fitness_function, ...
                'config', vararg.config, ...
                'genes', this.genes_, ...
                'activeNodes', this.activeNodes_, ...
                'programInputs', vararg.programInputs, ...
                'functionSet', {vararg.functionSet}, ...
                'run', vararg.config.run, ...
                'generation', vararg.config.generation ...
            ));
        end
    end
    
    methods (Access = private)
        function active = findActiveNodes_(this, sizes, connections)
            % findActiveNodes_ find the active nodes
            %
            %   To decode a genotype, it must be done from right, to left.
            %   In other words, from the output node, to its connection nodes, and
            %   so on, until we reach the CGP inputs.
            %
            %   Input:
            %       this {Genotype} instante of the class
            %           genes_ {array} array of genes of the genotype
            %       sizes  {struct} struct with sizes related constants
            %       connections {array}  array of connection genes
            %
            %   Examples:
            %       genotype.createParameters_(sizes, connections);

            % instantiate a zero vector with sufficient space
            active = zeros(1, sizes.nodes * 2);

            % add the output nodes as active
            active(1:sizes.outputs) = this.genes_(end - sizes.outputs + 1:end);

            % iterate through all active nodes
            for i = sizes.outputs:sizes.nodes * 2
                % skip input nodes, since they don't have connection nodes
                if active(i) <= sizes.inputs
                    continue;
                end

                % if the last nodes to check are all inputs, break the for loop
                % because we already know all the active nodes (including the
                % inputs)
                if all(active(i:end) <=  sizes.inputs)
                    break;
                end

                % for the current node being checked:
                %   mark the connection genes as active
                %   each of the connection genes will later be checked for its
                %   connections
                for j = 1:sizes.connection_genes
                    active(i + (i * 1) + j - 1) = this.genes_(connections{j}(active(i)));
                end
            end

            % sort the array
            % remove possible duplicates
            % remove zeros
            active = sort(active(active > 0));
            difference  = diff([active,NaN]);
            active = active(difference~=0);
        end
        
        function createParameters_(this, sizes, parameters)
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
            %       sizes {struct} struct with sizes related constants
            %       parameters {array} array of structs with 3 fields each:
            %           'name'       {string} the name of the parameter
            %           'initialize' {Handle} function handle which returns the parameter value
            %           'mutate'     {Handle} function handle to mutate the parameter value
            %
            %   Examples:
            %       genotype.createParameters_(struct(
            %           'inputs', 4,
            %           'genes', 101,
            %           'genes_per_node', 6,
            %           'parameters', 3
            %       ));
            %
            %       genotype.createParameters_(struct(
            %           'inputs', 2,
            %           'genes', 80,
            %           'genes_per_node', 4,
            %           'parameters', 1
            %       ));

            if sizes.parameters > 0
                for i = sizes.inputs + 4:sizes.genes_per_node:sizes.genes
                    for indexOfParameter = 1:sizes.parameters
                        this.genes_(i + indexOfParameter - 1) = parameters{indexOfParameter}.initialize();
                    end
                end
            end
        end
        
        function createProgramOutputs_(this, inputs, genes, outputs, nodes, shouldBeLastNode)
            % createOutputs_ create the CGP output genes in the genotype
            %
            %   After constructing all the connections, inputs, functions, and parameters,
            %   the final genes are reserved to the CGP output genes.
            %   The number of outputs could varie according to the needs
            %   and should be passed in the configuration process of the CGP.
            %
            %   Input:
            %       this {Genotype} instante of the class
            %           genes_ {array} array of genes of the genotype
            %       inputs  {integer} the number of CGP inputs
            %       genes   {integer} the number of all genes in the genotype
            %       outputs {integer} the number of CGP outputs
            %       nodes   {integer} the number of nodes in the genotype
            %
            %   Examples:
            %       genotype.createInputs_(4);
            %       genotype.createInputs_(2);

            for i = genes - outputs + 1:genes
                this.genes_(i) = cgptoolbox.Output(struct( ...
                    'numberOfInputs', inputs, ...
                    'numberOfNodes', nodes, ...
                    'shouldBeLastNode', shouldBeLastNode ...
                 )).get();
            end
        end
        
        function createProgramInputs_(this, inputs)
            % createInputs_ create the CGP input genes in the genotype
            %
            %   The first genes, are the input CGP genes. If we have 4 inputs
            %   the genotype will look like this:
            %       1, 2, 3, 4...
            %   In the decoding process, the gene number 1, will refer to the first
            %   input provided in the CGP, the gene number 2, will refer to the
            %   second one, etc.
            %   After those, the node genes are appended, so the next gene,
            %   will be a function gene.
            %
            %   Input:
            %       this {Genotype} instante of the class
            %           genes_ {array} array of genes of the genotype
            %       inputs {integer} the number of CGP inputs
            %
            %   Examples:
            %       genotype.createInputs_(4);
            %       genotype.createInputs_(2);

            this.genes_ = inputs;
        end
        
        function createFunctionGenes_(this, functionGenes, functionSet, inputs)
            % createFunctions_ create function genes for the genotype
            %
            %   Randomly select function genes, for the genotype.
            %
            %   Input:
            %       this {Genotype} instante of the class
            %           genes_ {array} array of genes of the genotype
            %
            %       inputs         {integer} the number of CGP inputs
            %       genes          {integer} the number of genes in the genotype
            %       genes_per_node {integer} the number of genes per node
            %       functions      {integer} the number of functions in the function-set
            %
            %   Examples:
            %       genotype.createFunctions_(4, 100, 6, 10);
            %       genotype.createFunctions_(2, 80, 6, 20);

            this.genes_(functionGenes(inputs+1:size(functionGenes, 2))) = cgptoolbox.Functions(struct( ...
                'sizeOfFunctionSet', functionSet, ...
                'numberOfFunctions', size(functionGenes, 2) - inputs ...
            )).get();
        end
        
        function createConnectionGenes_(this, structure, sizes)
            % createConnections_ create connections for a given node
            %
            %   Randomly select possible node connections, for a given node.
            %
            %   Input:
            %       this {Genotype} instante of the class
            %           genes_ {array} array of genes of the genotype
            %
            %       sizes {struct} structure with sizes related constants
            %           'inputs'           {integer} - the number of CGP inputs
            %           'connection_genes' {integer} - the number of connection genes for each node
            %           'genes_per_node'   {integer} - the number of genes per node
            %           'outputs'          {integer} - the number of CGP outputs
            %
            %   Examples:
            %       genotype.createConnections_(struct(
            %           'inputs', 4,
            %           'connection_genes', 2,
            %           'genes_per_node', 6,
            %           'outputs', 1
            %       ))
            %
            %       genotype.createConnections_(struct(
            %           'inputs', 2,
            %           'connection_genes', 3,
            %           'genes_per_node', 8,
            %           'outputs', 2
            %       ))

            %for i = sizes.inputs + 1:sizes.genes_per_node:sizes.genes - sizes.outputs
            for i = 1:sizes.connection_genes
                for j = sizes.inputs + 1:size(structure.connectionGenes{i}, 2)
                    this.genes_(structure.connectionGenes{i}(j)) = cgptoolbox.Connection(struct( ...
                        'sizes', sizes, ...
                        'geneIndex', structure.connectionGenes{i}(j) ...
                    )).get();
                end
            end
        end

    end
end
