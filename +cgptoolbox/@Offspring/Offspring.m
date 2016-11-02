classdef Offspring < handle
    % Offspring Class
    %   Create initial offspring of solutions
    %
    %   Initialize one genotype, and assign as the best fit.
    %   Iterate through the offspring sizes to create new genotypes.
    %   If one genotype has better fitness than the current fittest,
    %   replace the former.
    %
    %   Offspring Properties:
    %       candidateSolutions_  {Array}    array of solutions
    %       fittestSolution_    {Genotype} fittest solution of the offspring
    %
    %   Offspring Methods:
    %       solutions {public} get all the solutions in the offspring
    %       fittest   {public} get the fittest solution of the offspring

    properties (Access = private)
        configuration_
        candidateSolutions_
        fittestSolution_
    end

    methods (Access = public)

        function this = Offspring(vararg)
            % Offspring Constructor
            %
            %   Generate n solutions according to the offspring sizes.
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

            this.configuration_ = vararg;
        end

    end
end
