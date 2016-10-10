classdef Run < handle
    %RUN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        configuration_
        fitnessOfAllGenerations_ 
        fittestSolution_
    end
    
    methods (Access = public)
        
        function this = Run(vararg)            
            this.configuration_ = vararg;
            this.fitnessOfAllGenerations_ = zeros(1, this.configuration_.config.sizes.generations);
        end 
        
    end
    
    methods (Access = private)
        
        function fireCallback_(this, callback, activeNodes, genes)
            this.configuration_.callbacks.FITTEST_SOLUTION(struct(            ...
                'name', callback,                ...
                'generation', this.configuration_.config.generation,                ...
                'run', this.configuration_.config.run,                       ...
                'fitness', this.fitnessOfAllGenerations_(this.configuration_.config.generation), ...
                'functionSet', {this.configuration_.config.function_set},             ...
                'activeNodes', activeNodes,                          ...
                'genes', genes,                           ...
                'structure', this.configuration_.config.structure             ...
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