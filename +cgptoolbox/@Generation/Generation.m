classdef Generation
    % Generation Class
    %   Run a Generation
    %
    %   For each member in the population size:
    %       mutate the fittest solution of the previous generation
    %       if the newly mutated solution has better fitness than the previous, assign the fittest to this solution
    %   Fire the GENOTYPE callback
    %
    %   Generation Properties:
    %       fittest_ {Mutation} fittest genotype mutated
    %
    %   Generation Methods:
    %       fittest {public} get the fittest solution
    %
    %       isThisSolutionFitterThanParent_ {private} compare the solution mutated with the fittest

    properties (Access = private)
        fittest_
    end

    methods (Access = public)

        function this = Generation(        ...
            CONFIG,                        ...
            SIZE,                          ...
            STRUCTURE,                     ...
            inputs,                        ...
            functions,                     ...
            parameters,                    ...
            fittestFromPreviousGeneration, ...
            callbacks                     ...
        )
            % Generation Constructor
            %
            %   Input:
            %       CONFIG                        {struct} struct constant with configuration values
            %       SIZE                          {struct} size related struct constant
            %       STRUCTURE                     {Structure} struct constant with genes split into sections
            %       inputs                        {Array} array of CGP inputs
            %       functions                     {Array} array of functions from the function-set
            %       parameters                    {Array} array of parameters of the genotype
            %       fittestFromPreviousGeneration {Mutation} fittest genotype from the previous generation
            %       callbacks                     {struct} struct of callbacks to be executed at each section
            %
            %   Examples:
            %       Generation(CONFIG, SIZE, STRUCTURE, genes, active, inputs, functions)

            this.fittest_ = fittestFromPreviousGeneration;

            % for each population member mutate and generate new solutions
            for i = 1:SIZE.POPULATION
                
                if isfield(callbacks, 'NEW_SOLUTION_IN_GENERATION')
                    callbacks.NEW_SOLUTION_IN_GENERATION(...
                        'NEW_SOLUTION_IN_GENERATION', ...
                        i ...
                    );
                end

                solution = cgptoolbox.Mutation( ...
                    CONFIG, ...
                    STRUCTURE, ...
                    SIZE, ...
                    this.fittest_, ...
                    inputs, ...
                    functions, ...
                    parameters, ...
                    callbacks ...
                );
                
                % if the solution generated is better than the previous, update the fittest solution
                if (this.isThisSolutionFitterThanParent_(solution.fitness(), CONFIG.fitness_operator))
                    if isfield(callbacks, 'FITTEST_SOLUTION_OF_GENERATION')
                        callbacks.FITTEST_SOLUTION_OF_GENERATION(...
                            'FITTEST_SOLUTION_OF_GENERATION', ...
                            i ...
                        );
                    end
                    
                    this.fittest_ = solution;
                end

            end
        end
    end
end
