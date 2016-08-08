classdef Population
    % Population Class
    %   Create initial population of solutions
    %
    %   Initialize one genotype, and assign as the best fit.
    %   Iterate through the population size to create new genotypes.
    %   If one genotype has better fitness than the current fittest,
    %   replace the former.
    %
    %   Population Properties:
    %       solutions_  {Array}    array of solutions
    %       fittest_    {Genotype} fittest solution of the population
    %
    %   Population Methods:
    %       solutions {public} get all the solutions in the population
    %       fittest   {public} get the fittest solution of the population

    properties (Access = private)
        solutions_
        fittest_
    end

    methods (Access = public)

        function this = Population( ...
            CONFIG,                 ...
            SIZE,                   ...
            STRUCTURE,              ...
            inputs,                 ...
            functions,              ...
            parameters              ...
        )
            % Population Constructor
            %
            %   Generate n solutions according to the population size.
            %   Choose the fittest.
            %
            %   Input:
            %       CONFIG     {struct} struct constant with configuration values
            %       SIZE       {struct} size related struct constant
            %       STRUCTURE  {Structure} struct constant with genes split into sections
            %       inputs     {Array} inputs to the CGP
            %       functions  {Array} array of functions of the function-set
            %       parameters {Array} parameters to the genotype
            %
            %   Examples:
            %       Genotype(CONFIG, SIZE, STRUCTURE, inputs, functions, parametes)

            % create one genotype
            this.fittest_ = cgptoolbox.Genotype(CONFIG, SIZE, STRUCTURE, inputs, functions, parameters);

            % create the rest of the genotypes
            for i = 1:SIZE.POPULATION - 1
                this.solutions_{i} = cgptoolbox.Genotype(CONFIG, SIZE, STRUCTURE, inputs, functions, parameters);

                absolute_value = this.solutions_{i}.fitness();
                fitness_solution = this.fittest_.fitness();
                switch CONFIG.fitness_operator
                    case '>='
                        if absolute_value >= fitness_solution
                            this.fittest_ = this.solutions_{i};
                        end
                    case '<='
                        if absolute_value <= fitness_solution
                            this.fittest_ = this.solutions_{i};
                        end
                    case '>'
                        if absolute_value > fitness_solution
                            this.fittest_ = this.solutions_{i};
                        end
                    case '<'
                        if absolute_value < fitness_solution
                            this.fittest_ = this.solutions_{i};
                        end
                    otherwise
                        if absolute_value >= fitness_solution
                            this.fittest_ = this.solutions_{i};
                        end
                end
            end
        end

    end
end
