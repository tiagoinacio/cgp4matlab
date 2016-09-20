classdef Fitness
    % Fitness Class
    %   Handle the fitness of a particular solution
    %
    %   The Fitness class receives multiple parameters, which are then
    %   dispatch to the fitness function provided by the user. With this
    %   parameters, the user has access to almost all the properties of the
    %   CGP, including the genotype configuration, active genes, inputs, etc.
    %   The fitness function is than called, with those parameters, and the
    %   result is stored in the `fitness_` propertie. The result is than
    %   validated, to check if it is indeed a numeric type.
    %
    %   Fitness Properties:
    %       fitness_ {Number} fitness value
    %
    %   Fitness Methods:
    %       get - get the fitness value

    properties (Access = private)
        fitness_
    end

    methods (Access = public)

        function this = Fitness(vararg)
            % Fitness Fitness Constructor
            %
            %   Input:
            %       config    {struct} struct constant with configuration values
            %       sizes      {struct} sizes related struct constant
            %       structure {Structure} struct constant with genes split into sections
            %       genes     {Array} array of genes, the genotype
            %       active    {Array} array of active nodes
            %       inputs    {Array} inputs of the CGP
            %       functions {Array} array of functions from the function-set
            %
            %   Examples:
            %       Fitness(config, sizes, structure, genes, active, inputs, functions)

            % get the fitness value
            this.fitness_ = vararg.fitness_function(struct( ...
                'config', vararg.config, ...
                'genes', vararg.genes, ...
                'activeNodes', vararg.activeNodes, ...
                'programInputs', vararg.programInputs, ...
                'functionSet', {vararg.functionSet}, ...
                'run', vararg.run, ...
                'generation', vararg.generation ...
            ));

            % check if is a numeric value
            if ~isnumeric(this.fitness_)
                error('CGP:FITNESS:FitnessMustBeANumericValue', 'The Fitness value must be a numeric value');
            end
        end
    end
end
