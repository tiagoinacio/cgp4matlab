function this = createMutation(this)
    % store the initial genotype
    this.genes_ = this.configuration_.fittestSolution.getGenes();
    hasCallback = isfield(this.configuration_.callbacks, 'GENOTYPE_MUTATED');

    % initialize empty array for mutated genes
    if hasCallback
        genesMutated = 1:this.configuration_.config.sizes.genes;
    end

    for i = this.configuration_.config.sizes.inputs + 1:this.configuration_.config.sizes.genes
        if rand() <= this.configuration_.config.sizes.mutation
            % store the mutated genes
            if hasCallback
                genesMutated(i) = i;
            end

            % mutate
            this.genes_(i) = this.mutate_( ...
                this.configuration_.config.sizes, ...
                this.configuration_.config.structure, ...
                i, ...
                this.configuration_.parameters, ...
                this.configuration_.config.last_node_output ...
            );
        end
    end

    % assign the active nodes
    this.activeNodes_ = this.findActiveNodes_(this.configuration_.config.sizes, this.configuration_.config.structure.connectionGenes);

    %if isequal(this.activeNodes_, this.configuration_.fittestSolution.getActiveNodes())
    %    this.fitness_ = this.configuration_.fittestSolution.getFitness();
    %else
        % assign the fitness for this solution
        this.fitness_ = cgptoolbox.Fitness(struct( ...
            'fitness_function', this.configuration_.config.fitness_function, ...
            'config', this.configuration_.config, ...
            'genes', this.genes_, ...
            'activeNodes', this.activeNodes_, ...
            'programInputs', this.configuration_.programInputs, ...
            'functionSet', {this.configuration_.functionSet}, ...
            'run', this.configuration_.config.run, ...
            'generation', this.configuration_.config.generation ...
        )).getFitness();
    %end

    % fire the GENOTYPE_MUTATED callback
    if hasCallback
        this.configuration_.callbacks.GENOTYPE_MUTATED(this.configuration_.fittestSolution.getGenes(), this.genes_, genesMutated);
    end
end

