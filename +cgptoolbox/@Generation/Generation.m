classdef Generation
    % Generation Class
    %   Run a Generation

    properties (Access = private)
        fittestSolution_
    end

    methods (Access = public)

        function this = Generation(vararg)

            this.fittestSolution_ = vararg.fittestSolution;

            % for each offspring mutate and generate new solutions
            for i = 1:vararg.config.sizes.offsprings

                if isfield(vararg.callbacks, 'NEW_SOLUTION_IN_GENERATION')
                    vararg.callbacks.NEW_SOLUTION_IN_GENERATION(struct( ...
                        'name', 'NEW_SOLUTION_IN_GENERATION', ...
                        'offspringIndex', i, ...
                        'generation', vararg.config.generation, ...
                        'genes', this.fittestSolution_.getGenes(), ...
                        'fitness', this.fittestSolution_.getFitness(), ...
                        'activeNodes', this.fittestSolution_.getActiveNodes() ...
                    ));
                end

                solution = cgptoolbox.Mutation(vararg);

                % if the solution generated is better than the previous, update the fittest solution
                if (this.isThisSolutionFitterThanParent_(solution.getFitness(), vararg.config.fitness_operator))
                    if isfield(vararg.callbacks, 'FITTEST_SOLUTION_OF_GENERATION')
                        vararg.callbacks.FITTEST_SOLUTION_OF_GENERATION(struct( ...
                            'name', 'FITTEST_SOLUTION_OF_GENERATION', ...
                            'offspringIndex', i, ...
                            'generation', vararg.config.generation, ...
                            'genes', this.fittestSolution_.getGenes(), ...
                            'fitness', this.fittestSolution_.getFitness(), ...
                            'activeNodes', this.fittestSolution_.getActiveNodes() ...
                        ));
                    end

                    this.fittestSolution_ = solution;
                    vararg.fittestSolution = solution;
                end

            end
        end
    end
    
    methods (Access = private)
        function bool = isThisSolutionFitterThanParent_(this, solutionFitness, fitness_operator)
            % isThisSolutionFitterThanParent_ checks if the new solution is better than the previous
            %
            %   Checks for the fitness value of the previous solution, and the new generated solution.
            %
            %   Output {bool} If the new solution has better fitness, return true.
            %                 If the previous solution has better fitness, return false.
            %
            %   Input:
            %       this {Generation} instante of the class
            %       solutionFitness {Number} fitness value from the new generated solution
            %       solutionFitness {Char} fitness operator to use
            %
            %   Examples:
            %       generation.isThisSolutionFitterThanParent_(10, '>=');
            %       generation.isThisSolutionFitterThanParent_(0.2, '<');

            absolute_value = solutionFitness;
            fitness_solution =  this.fittestSolution_.getFitness();
            switch fitness_operator
                case '>='
                    bool = absolute_value >= fitness_solution;
                case '<='
                    bool = absolute_value <= fitness_solution;
                case '>'
                    bool = absolute_value > fitness_solution;
                case '<'
                    bool = absolute_value < fitness_solution;
                otherwise
                    bool = absolute_value >= fitness_solution;
            end
        end
    end
end
