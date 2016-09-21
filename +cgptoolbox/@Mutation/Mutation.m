classdef Mutation
    % Mutation Class
    %   Mutate a genotype
    %
    %   Mutate a number of genes in the genotype, according to the percentage of mutation.
    %   The `genes_` propertie will be updated at each mutation.
    %   After mutation, assign the fitness value and the new active nodes.
    %   If the GENOTYPE_MUTATED callback is passed, fire up the callback
    %   with the new genotype and the mutated genes.
    %
    %   Mutation Properties:
    %       activeNodes_  {array} arary of active nodes
    %       genes_   {array} array of genes
    %       fitness_ {Number} fitness value
    %
    %   Mutation Methods:
    %       active  {public} get the active genes
    %       fitness {public} get the fitness value
    %       genes   {public} get the genotype genes
    %
    %       findActiveNodes          {private} find which nodes are active
    %       getNumberOfGenesToMutate_ {private} create the input genes
    %       getRandomGene_            {private} create the connection genes
    %       mutate                   {private} create the function genes

    properties (Access = private)
        activeNodes_
        genes_
        fitness_
    end

    methods (Access = public)

        function this = Mutation (vararg)
            % Mutation Constructor
            %
            %   Input:
            %       config     {struct} struct constant with configuration values
            %       structure  {Structure} struct constant with genes split into sections
            %       sizes       {struct} sizes related struct constant
            %       fittest    {Genotype} fittest genotype of previous generation
            %       inputs     {Array} array of CGP inputs
            %       functions  {Array} array of functions from the function-set
            %       parameters {Array} array of parameters of the genotype
            %       callbacks  {Array} array of callbacks to be executed at each section
            %
            %   Examples:
            %       Genotype(config, sizes, structure, inputs, functions, parameters)

            % store the initial genotype
            this.genes_ = vararg.fittestSolution.getGenes();

            % initialize empty array for mutated genes
            if isfield(vararg.callbacks, 'GENOTYPE_MUTATED')
                genesMutated = 1:vararg.config.sizes.genes;
            end

            for i = vararg.config.sizes.inputs + 1:vararg.config.sizes.genes
                if rand() <= vararg.config.sizes.mutation
                    % store the mutated genes
                    if isfield(vararg.callbacks, 'GENOTYPE_MUTATED')
                        genesMutated(i) = i;
                    end

                    % mutate
                    this.genes_(i) = this.mutate_(vararg.config.sizes, vararg.config.structure, i, vararg.parameters, vararg.config.last_node_output);
                end
            end

            % assign the active nodes
            this.activeNodes_ = this.findActiveNodes_(vararg.config.sizes, vararg.config.structure.connectionGenes);

            %if isequal(this.activeNodes_, vararg.fittestSolution.getActiveNodes())
            %    this.fitness_ = vararg.fittestSolution.getFitness();
            %else
                % assign the fitness for this solution
                this.fitness_ = cgptoolbox.Fitness(struct( ...
                    'fitness_function', vararg.config.fitness_function, ...
                    'config', vararg.config, ...
                    'genes', this.genes_, ...
                    'activeNodes', this.activeNodes_, ...
                    'programInputs', vararg.programInputs, ...
                    'functionSet', {vararg.functionSet}, ...
                    'run', vararg.config.run, ...
                    'generation', vararg.config.generation ...
                )).get();
            %end

            % fire the GENOTYPE_MUTATED callback
            if isfield(vararg.callbacks, 'GENOTYPE_MUTATED')
                vararg.callbacks.GENOTYPE_MUTATED(vararg.fittestSolution.getGenes(), this.genes_, genesMutated);
            end
        end
    end
    
    methods (Access = private)
        function newValue = mutate_(this, sizes, structure, gene, parameters, shouldBeLastNode)
            % mutate_ mutate one gene
            %
            %   Find the type of gene to be mutated:
            %       output gene
            %       connection gene
            %       parameter gene
            %       function gene
            %
            %   According to the type, mutate the gene value.
            %
            %   Input:
            %       this {Mutation} instante of the class
            %           genes_ {array} array of genes of the genotype
            %       sizes             {struct} sizes related struct constant
            %       structure        {Structure} struct constant with genes split into sections
            %       gene             {integer} gene to be mutated
            %       parameters       {Array} array of parameters of the genotype
            %       shouldBeLastNode {bool}  if the output is the last node
            %
            %   Examples:
            %       mutation.mutate_(sizes, structure, gene, parameters, shouldBeLastNode);

            % mutate output
            if (any(gene == structure.programOutputs))
                newValue = cgptoolbox.Output(struct( ...
                    'numberOfInputs', sizes.inputs, ...
                    'numberOfNodes', sizes.nodes, ...
                    'shouldBeLastNode', shouldBeLastNode ...
                )).get();
                %gene = gene - 1;
                return;
            end

            % mutate connection
            if (any(gene == [structure.connectionGenes{1}, structure.connectionGenes{2}]))
                newValue = cgptoolbox.Connection(struct( ...
                        'sizes', sizes, ...
                        'geneIndex', gene ...
                    )).get();
                return;
            end

            % mutate parameter
            if sizes.parameters > 0 && any(any(gene == structure.parameters))
                for i = 1:sizes.parameters
                    if any(gene == structure.parameters(i,:))
                        newValue = parameters{i}.mutate(this.genes_(gene));
                        return;
                    end
                end
            end

            % mutate function
            newValue = cgptoolbox.Functions(struct( ...
                'sizeOfFunctionSet', sizes.functions, ...
                'numberOfFunctions', 1 ...
            )).get();
        end
        
        function activeNodes_ = findActiveNodes_(this, sizes, connections)
            % findActiveNodes_ find the active nodes
            %
            %   To decode a genotype, it must be done from right, to left.
            %   In other words, from the output node, to its connection nodes, and
            %   so on, until we reach the CGP inputs.
            %
            %   Input:
            %       this {Mutation} instante of the class
            %           genes_ {array} array of genes of the genotype
            %       sizes        {struct} struct with sizes related constants
            %       connections {array}  array of connection genes
            %
            %   Examples:
            %       genotype.createParameters_(sizes, connections);

            % instantiate a zero vector with sufficient space
            activeNodes_ = zeros(1, sizes.nodes * 2);

            % add the output nodes as active
            activeNodes_(1:sizes.outputs) = this.genes_(end - sizes.outputs + 1:end);

            % iterate through all active nodes
            for i = sizes.outputs:sizes.nodes * 2
                % skip input nodes, since they don't have connection nodes
                if activeNodes_(i) <= sizes.inputs
                    continue;
                end

                % if the last nodes to check are all inputs, break the for loop
                % because we already know all the active nodes (including the
                % inputs)
                if all(activeNodes_(i:end) <=  sizes.inputs)
                    break;
                end

                % for the current node being checked:
                %   mark the connection genes as active
                %   each of the connection genes will later be checked for its
                %   connections
                for j = 1:sizes.connection_genes
                    activeNodes_(i + (i * 1) + j - 1) = this.genes_(connections{j}(activeNodes_(i) - sizes.inputs));
                end
            end

            % sort the array
            % remove possible duplicates
            % remove zeros
            activeNodes_ = sort(activeNodes_(activeNodes_ > 0));
            difference  = diff([activeNodes_,NaN]);
            activeNodes_ = activeNodes_(difference~=0);
        end

    end
end
