function gene = getRandomGene_(~, allGenes, numberOfInputs, numberOfOutputs, shouldMutateOutputs)
    % getRandomGene_ return a random index gene
    %
    %   Randomly select a gene from the genotype to be mutated.
    %   If the outputs are not the last nodes, include the outputs
    %   to be mutated.
    %
    %   Input:
    %       ~                   {void} instante of the class
    %       allGenes            {Number} number of all genes in the genotype, inluding inputs and outputs
    %       numberOfInputs      {Integer} number of CGP input genes
    %       numberOfOutputs     {Integer} number of CGP output genes
    %       shouldMutateOutputs {bool} should mutate the outputs
    %
    %   Examples:
    %       genotype.getNumberOfGenesToMutate_(0.2, 60);
    %       genotype.getNumberOfGenesToMutate_(0.1, 100);

    if shouldMutateOutputs
        % include the output genes in the mutation
        gene = randi(allGenes - numberOfInputs) + numberOfInputs;
    else
        % exclude the output genes
        gene = randi(allGenes - numberOfInputs - numberOfOutputs) + numberOfInputs;
    end
end
