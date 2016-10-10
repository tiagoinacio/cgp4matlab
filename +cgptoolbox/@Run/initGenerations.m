function initGenerations(this)
    
    while this.solutionNotFound_(this.configuration_.config.fitness_solution, this.configuration_.config.fitness_operator) && this.maxGenerationNotReached_(this.configuration_.config.generation, this.configuration_.config.sizes.generations)

        % create new generation
        generation = cgptoolbox.Generation(this.configuration_);

        generation.mutate();

        % assign best fit individual to parent
        this.fittestSolution_ = generation.getFittestSolution();

        % assign fitness for this generation
        this.fitnessOfAllGenerations_(this.configuration_.config.generation) = this.fittestSolution_.getFitness();

        genes = this.fittestSolution_.getGenes();
        activeNodes = this.fittestSolution_.getActiveNodes();

        if isfield(this.configuration_.callbacks, 'FITTEST_SOLUTION')
            if this.configuration_.config.generation - 1 ~= 0
                if strcmp(this.configuration_.config.fitness_operator, '<=') || strcmp(this.configuration_.config.fitness_operator, '<')
                    if this.fitnessOfAllGenerations_(this.configuration_.config.generation) < this.fitnessOfAllGenerations_(this.configuration_.config.generation - 1)
                        this.fireCallback_('FITTEST_SOLUTION', activeNodes, genes);
                    end
                elseif strcmp(this.configuration_.config.fitness_operator, '>=') || strcmp(this.configuration_.config.fitness_operator, '>')
                    if this.fitnessOfAllGenerations_(this.configuration_.config.generation) > this.fitnessOfAllGenerations_(this.configuration_.config.generation - 1)
                        this.fireCallback_('FITTEST_SOLUTION', activeNodes, genes);
                    end
                end
            end
        end

        if isfield(this.configuration_.callbacks, 'NEW_GENERATION')
            this.configuration_.callbacks.NEW_GENERATION(struct(            ...
                'name', 'NEW_GENERATION',                ...
                'generation', this.configuration_.config.generation,                ...
                'run', this.configuration_.config.run,                       ...
                'fitness', this.fitnessOfAllGenerations_(this.configuration_.config.generation), ...
                'functionSet', {this.configuration_.config.function_set},             ...
                'activeNodes', activeNodes,                          ...
                'genes', genes,                           ...
                'structure', this.configuration_.config.structure ...
            ));
        end

        this.configuration_.config.generation = this.configuration_.config.generation + 1;
        this.configuration_.fittestSolution = this.fittestSolution_;
    end

    this.fitnessOfAllGenerations_(this.configuration_.config.generation) = this.fittestSolution_.getFitness();
end

