classdef Offsprings < handle
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
        configuration_
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

            this.configuration_ = vararg;
        end

    end
end
