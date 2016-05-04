function createOutputs_(this, INPUTS, GENES, OUTPUTS, NODES, shouldBeLastNode)
    % createOutputs_ create the CGP output genes in the genotype
    %
    %   After constructing all the connections, inputs, functions, and parameters,
    %   the final genes are reserved to the CGP output genes.
    %   The number of outputs could varie according to the needs
    %   and should be passed in the configuration process of the CGP.
    %
    %   Input:
    %       this {Genotype} instante of the class
    %           genes_ {array} array of genes of the genotype
    %       INPUTS  {integer} the number of CGP inputs
    %       GENES   {integer} the number of all genes in the genotype
    %       OUTPUTS {integer} the number of CGP outputs
    %       NODES   {integer} the number of nodes in the genotype
    %
    %   Examples:
    %       genotype.createInputs_(4);
    %       genotype.createInputs_(2);

    for i = GENES - OUTPUTS + 1:GENES
        this.genes_(i) = cgptoolbox.Output(INPUTS, NODES, shouldBeLastNode).get();
    end
end
