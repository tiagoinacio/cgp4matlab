function createFunctions_(this, INPUTS, GENES, GENES_PER_NODE, FUNCTIONS)
    % createFunctions_ create function genes for the genotype
    %
    %   Randomly select function genes, for the genotype.
    %
    %   Input:
    %       this {Genotype} instante of the class
    %           genes_ {array} array of genes of the genotype
    %
    %       INPUTS         {integer} the number of CGP inputs
    %       GENES          {integer} the number of genes in the genotype
    %       GENES_PER_NODE {integer} the number of genes per node
    %       FUNCTIONS      {integer} the number of functions in the function-set
    %
    %   Examples:
    %       genotype.createFunctions_(4, 100, 6, 10);
    %       genotype.createFunctions_(2, 80, 6, 20);

    functionGenes = INPUTS + 1:GENES_PER_NODE:GENES;
    this.genes_(functionGenes) = cgptoolbox.Function(FUNCTIONS, size(functionGenes, 2)).get();
end
