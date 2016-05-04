function active = findActiveNodes_(this, SIZE, CONNECTIONS)
    % findActiveNodes_ find the active nodes
    %
    %   To decode a genotype, it must be done from right, to left.
    %   In other words, from the output node, to its connection nodes, and
    %   so on, until we reach the CGP inputs.
    %
    %   Input:
    %       this {Genotype} instante of the class
    %           genes_ {array} array of genes of the genotype
    %       SIZE  {struct} struct with size related constants
    %       CONNECTIONS {array}  array of connection genes
    %
    %   Examples:
    %       genotype.createParameters_(SIZE, CONNECTIONS);

    % instantiate a zero vector with sufficient space
    active = zeros(1, SIZE.NODES * 2);

    % add the output nodes as active
    active(1:SIZE.OUTPUTS) = this.genes_(end - SIZE.OUTPUTS + 1:end);

    % iterate through all active nodes
    for i = SIZE.OUTPUTS:SIZE.NODES * 2
        % skip input nodes, since they don't have connection nodes
        if active(i) <= SIZE.INPUTS
            continue;
        end
        
        % if the last nodes to check are all inputs, break the for loop
        % because we already know all the active nodes (including the
        % inputs)
        if all(active(i:end) <=  SIZE.INPUTS)
            break;
        end
        
        % for the current node being checked:
        %   mark the connection genes as active
        %   each of the connection genes will later be checked for its
        %   connections
        for j = 1:SIZE.CONNECTION_GENES
            active(i + (i * 1) + j - 1) = this.genes_(CONNECTIONS{j}(active(i)));
        end
    end

    % sort the array
    % remove possible duplicates
    % remove zeros
    active = sort(active(active > 0));
    difference  = diff([active,NaN]);
    active = active(difference~=0);
end
