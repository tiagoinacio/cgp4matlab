classdef Offsprings
    % Offsprings Class
    %   Create initial offsprings of solutions
    %
    %   Initialize one genotype, and assign as the best fit.
    %   Iterate through the offsprings sizes to create new genotypes.
    %   If one genotype has better fitness than the current fittest,
    %   replace the former.
    %
    %   Offsprings Properties:
    %       candidateSolutions_  {Array}    array of solutions
    %       fittestSolution_    {Genotype} fittest solution of the offsprings
    %
    %   Offsprings Methods:
    %       solutions {public} get all the solutions in the offsprings
    %       fittest   {public} get the fittest solution of the offsprings

    properties (Access = private)
        candidateSolutions_
        fittestSolution_
    end

    methods (Access = public)

        function this = Offsprings(vararg)
            % Offsprings Constructor
            %
            %   Generate n solutions according to the offsprings sizes.
            %   Choose the fittest.
            %
            %   Input:
            %       config     {struct} struct constant with configuration values
            %       sizes       {struct} sizes related struct constant
            %       structure  {Structure} struct constant with genes split into sections
            %       inputs     {Array} inputs to the CGP
            %       functions  {Array} array of functions of the function-set
            %       parameters {Array} parameters to the genotype
            %
            %   Examples:
            %       Genotype(config, sizes, structure, inputs, functions, parametes)

            % create one genotype
            this.fittestSolution_ = cgptoolbox.Genotype(vararg);

            % create the rest of the genotypes
            for i = 1:vararg.config.sizes.offsprings - 1
                this.candidateSolutions_{i} = cgptoolbox.Genotype(vararg);

                absolute_value = this.candidateSolutions_{i}.getFitness();
                fitness_solution = this.fittestSolution_.getFitness();
                switch vararg.config.fitness_operator
                    case '>='
                        if absolute_value >= fitness_solution
                            this.fittestSolution_ = this.candidateSolutions_{i};
                        end
                    case '<='
                        if absolute_value <= fitness_solution
                            this.fittestSolution_ = this.candidateSolutions_{i};
                        end
                    case '>'
                        if absolute_value > fitness_solution
                            this.fittestSolution_ = this.candidateSolutions_{i};
                        end
                    case '<'
                        if absolute_value < fitness_solution
                            this.fittestSolution_ = this.candidateSolutions_{i};
                        end
                    otherwise
                        if absolute_value >= fitness_solution
                            this.fittestSolution_ = this.candidateSolutions_{i};
                        end
                end
            end
        end

    end
end
