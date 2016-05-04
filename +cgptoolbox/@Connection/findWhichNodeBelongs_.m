function node = findWhichNodeBelongs_(~, SIZE, gene)
    % findWhichNodeBelongs_ Find the node which a given gene belongs to
    %
    %   Given a specific gene, find which node belongs to
    %   Since the gene contains the CGP inputs plus the genotype genes,
    %   one must find first the node which belongs to in the genotype, and
    %   add the CGP node inputs.
    %
    %   Input:
    %       ~    {void} skip the Connection class instance
    %       SIZE {struct} struct with size related constants
    %           'INPUTS'         { integer} number of CGP inputs
    %           'GENES_PER_NODE' { integer} number of genes per node (connection genes + function gene + parameters)
    %       gene {integer} gene which needs to be checked
    %
    %   Examples:
    %       cgp.findWhichNodeBelongs_(struct(
    %           'INPUTS', 2,
    %           'GENES_PER_NODE', 5
    %       ), 10)
    %
    %       cgp.findWhichNodeBelongs_(struct(
    %           'INPUTS', 4,
    %           'GENES_PER_NODE', 3
    %       ), 5)

    node = ceil((gene - SIZE.INPUTS) / SIZE.GENES_PER_NODE) + SIZE.INPUTS;
end