function newValue = mutate_(this, SIZE, STRUCTURE, gene, parameters, shouldBeLastNode)
    % mutate_ mutate one gene
    %
    %   Find the type of gene to be mutated:
    %       output gene
    %       connection gene
    %       parameter gene
    %       function gene
    %
    %   According to the type, mutate the gene value.
    %
    %   Input:
    %       this {Mutation} instante of the class
    %           genes_ {array} array of genes of the genotype
    %       SIZE             {struct} size related struct constant
    %       STRUCTURE        {Structure} struct constant with genes split into sections
    %       gene             {integer} gene to be mutated
    %       parameters       {Array} array of parameters of the genotype
    %       shouldBeLastNode {bool}  if the output is the last node
    %
    %   Examples:
    %       mutation.mutate_(SIZE, STRUCTURE, gene, parameters, shouldBeLastNode);

    % mutate output
    if (any(gene == STRUCTURE.OUTPUTS))
        newValue = cgptoolbox.Output(SIZE.INPUTS, SIZE.NODES, shouldBeLastNode).get();
        %gene = gene - 1;
        return;
    end

    % mutate connection
    if (any(gene == [STRUCTURE.CONNECTIONS{1}, STRUCTURE.CONNECTIONS{2}]))
        newValue = cgptoolbox.Connection(SIZE, gene).get();
        return;
    end

    % mutate parameter
    if SIZE.PARAMETERS > 0 && any(gene == STRUCTURE.PARAMETERS)
        for i = 1:SIZE.PARAMETERS
            if any(gene == STRUCTURE.PARAMETERS_ORDER(i,:))
                newValue = parameters{i}.mutate(this.genes_(gene));
                return;
            end
        end
    end

    % mutate function
    newValue = cgptoolbox.Function(SIZE.FUNCTIONS, 1).get();
end
