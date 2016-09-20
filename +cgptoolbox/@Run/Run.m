classdef Run
    %RUN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        fitnessOfAllGenerations_ 
        fittestSolution_
    end
    
    methods (Access = public)
        
        function this = Run(vararg)
            
            this.fittestSolution_ = cgptoolbox.Offsprings(struct( ...
                'config', vararg.config, ...
                'programInputs', vararg.programInputs, ...
                'functionSet', {vararg.functionSet}, ...
                'parameters', {vararg.parameters} ...
            )).getFittestSolution();
        
            this.fitnessOfAllGenerations_ = zeros(1, vararg.config.sizes.generations);
            vararg.fittestSolution = this.fittestSolution_;

            while this.solutionNotFound_(vararg.config.fitness_solution, vararg.config.fitness_operator) && this.maxGenerationNotReached_(vararg.config.generation, vararg.config.sizes.generations)

                % create new generation
                generation = cgptoolbox.Generation(vararg);

                % assign best fit individual to parent
                this.fittestSolution_ = generation.getFittestSolution();
                
                % assign fitness for this generation
                this.fitnessOfAllGenerations_(vararg.config.generation) = this.fittestSolution_.getFitness();

                genes = this.fittestSolution_.getGenes();
                activeNodes = this.fittestSolution_.getActiveNodes();

                if isfield(vararg.callbacks, 'FITTEST_SOLUTION')
                    if vararg.config.generation - 1 ~= 0
                        if strcmp(vararg.config.fitness_operator, '<=') || strcmp(vararg.config.fitness_operator, '<')
                            if this.fitnessOfAllGenerations_(vararg.config.generation) < this.fitnessOfAllGenerations_(vararg.config.generation - 1)
                                this.fireCallback_('FITTEST_SOLUTION', vararg, activeNodes, genes);
                            end
                        elseif strcmp(vararg.config.fitness_operator, '>=') || strcmp(vararg.config.fitness_operator, '>')
                            if this.fitnessOfAllGenerations_(vararg.config.generation) > this.fitnessOfAllGenerations_(vararg.config.generation - 1)
                                this.fireCallback_('FITTEST_SOLUTION', vararg, activeNodes, genes);
                            end
                        end
                    end
                end

                if isfield(vararg.callbacks, 'NEW_GENERATION')
                    vararg.callbacks.NEW_GENERATION(struct(            ...
                        'name', 'NEW_GENERATION',                ...
                        'generation', vararg.config.generation,                ...
                        'run', vararg.config.run,                       ...
                        'fitness', this.fitnessOfAllGenerations_(vararg.config.generation), ...
                        'functionSet', {vararg.config.function_set},             ...
                        'activeNodes', activeNodes,                          ...
                        'genes', genes,                           ...
                        'structure', vararg.config.structure ...
                    ));
                end

                vararg.config.generation = vararg.config.generation + 1;
                vararg.fittestSolution = this.fittestSolution_;
            end
            
            this.fitnessOfAllGenerations_(vararg.config.generation) = this.fittestSolution_.getFitness();
        end 
        
    end
    
    methods (Access = private)
        
        function fireCallback_(this, callback, vararg, activeNodes, genes)
            vararg.callbacks.FITTEST_SOLUTION(struct(            ...
                'name', callback,                ...
                'generation', vararg.config.generation,                ...
                'run', vararg.config.run,                       ...
                'fitness', this.fitnessOfAllGenerations_(vararg.config.generation), ...
                'functionSet', {vararg.config.function_set},             ...
                'activeNodes', activeNodes,                          ...
                'genes', genes,                           ...
                'structure', vararg.config.structure             ...
            ));
        end
        
        function notFound = solutionNotFound_(this, fitness_solution, fitness_operator)
            % solutionNotFound_ check if a solution is a valid solution or not
            %
            %   If the absolute value of the fittest's fitness solution is less
            %   then the minimum fitness for a valid solution, returns true.
            %   If the fitness is bigger than the threshold `solutions_fitness`,
            %   returns false.
            %
            %   Input:
            %       this             {EA} instance of EA class
            %       fittestSolution_         {Genotype} fittest solution
            %       fitness_value    {integer} fitness of the current solution being evalutated
            %       fitness_operator {string} if the operator to be used is bigger then or less then from the solution fitness
            %
            %   Examples:
            %       ea.solutionNotFound_(0.01, '>=');
            %       ea.solutionNotFound_(0.1, '<');

            absolute_value = abs(this.fittestSolution_.getFitness());
            switch fitness_operator
                case '>='
                    notFound = ~(absolute_value >= fitness_solution);
                case '<='
                    notFound = ~(absolute_value <= fitness_solution);
                case '>'
                    notFound = ~(absolute_value > fitness_solution);
                case '<'
                    notFound = ~(absolute_value < fitness_solution);
                otherwise
                    notFound = ~(absolute_value >= fitness_solution);
            end
        end

        function bool = maxGenerationNotReached_(~, generation, generations)
            % maxGenerationNotReached_ Return true if the maximum generations number was not reached
            %   If the current generation is less than the maximum generations limit, return true.
            %   Otherwise return false.
            %
            %   Output:
            %       bool {bool} true if maximum generation was not reached
            %                   false if the maximum generation was reached
            %
            %   Input:
            %       this            {EA} instance of EA class
            %           generation_ {integer} current generation
            %       generations     {Integer} number of maximum generations
            %
            %   Examples:
            %       ea.maxGenerationNotReached(500);
            %       ea.maxGenerationNotReached(1000);

            bool = generation <= generations;
        end

    end
end