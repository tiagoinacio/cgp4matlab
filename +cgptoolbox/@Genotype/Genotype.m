classdef Genotype < handle
    % Genotype Class
    %   Instatiate a genotype
    %
    %   Create the input genes
    %   Create the function genes
    %   Create the connection genes
    %   Create the parameter genes
    %   Create the output genes
    %   Find which nodes are active and calculate the fitness of this genotype/solution.
    %
    %   Genotype Properties:
    %       active_  {array} arary of active nodes
    %       genes_   {array} array of genes
    %       fitness_ {Number} fitness value
    %
    %   Genotype Methods:
    %       active  {public} get the active genes
    %       fitness {public} get the fitness value
    %       genes   {public} get the genotype genes
    %
    %       createConnections_ {private} create the connection genes
    %       createFunctions_   {private} create the function genes
    %       createInputs_      {private} create the input genes
    %       createOutputs_     {private} create the output genes
    %       findActiveNodes_   {private} find which nodes are active

    properties (Access = private)
        active_
        genes_
    end
    
    properties (Access = public)
        fitness_
    end

    methods (Access = public)

        function this = Genotype(CONFIG, SIZE, STRUCTURE, inputs, functions, parameters)
            % Genotype Constructor
            %
            %   Input:
            %       CONFIG     {struct} struct constant with configuration values
            %       SIZE       {struct} size related struct constant
            %       STRUCTURE  {Structure} struct constant with genes split into sections
            %       inputs     {Array} array of CGP inputs
            %       functions  {Array} array of functions from the function-set
            %       parameters {Array} array of parameters of the genotype
            %
            %   Examples:
            %       Genotype(CONFIG, SIZE, STRUCTURE, inputs, functions, parameters)

            this.genes_ = zeros(1, SIZE.GENES);

            this.createInputs_(SIZE.INPUTS);
            this.createFunctions_(SIZE.INPUTS, SIZE.GENES, SIZE.GENES_PER_NODE, SIZE.FUNCTIONS);
            this.createConnections_(SIZE);
            this.createParameters_(SIZE, parameters);
            this.createOutputs_(SIZE.INPUTS, SIZE.GENES, SIZE.OUTPUTS, SIZE.NODES, CONFIG.last_node_output);

            this.active_ = this.findActiveNodes_(SIZE, STRUCTURE.CONNECTIONS);

            this.fitness_ = cgptoolbox.Fitness(CONFIG, SIZE, STRUCTURE, this.genes_, this.active_, inputs, functions);
        end
    end
end
