function connections = findPossibleConnections_(this, SIZE)
    % findPossibleConnections_ Find all nodes before the current one, plus the inputs for the CGP
    %
    %   Given a specific node form the genotype, get a list of all possible node connections
    %   The list should have all the nodes before the current one, while in the range of the levels_back parameter
    %       Instantiates a vector with the levels back size
    %       Checks if there are any possible node connections, within the
    %       same row
    %       If the levels back is still not reached, find the possible
    %       node inputs
    %
    %   Input:
    %       this {Connection} instance of the Connection class
    %           'node_' - propertie which stores an integer, representing the current node
    %       SIZE {struct} struct with size related constants
    %           'LEVELS_BACK'    {integer} number of the previous nodes, which a node can connect to
    %           'ROWS'           {integer} number of rows
    %           'INPUTS'         {integer} number of CGP inputs
    %           'GENES_PER_NODE' {integer} number of genes per node (connection genes + function gene + parameters)
    %
    %   Examples:
    %       cgp.findPossibleConnections_(struct(
    %           'LEVELS_BACK', 16,
    %           'ROWS', 16,
    %           'INPUTS', 2,
    %           'GENES_PER_NODE', 5
    %       ))
    %
    %       cgp.findPossibleConnections_(struct(
    %           'LEVELS_BACK', 10,
    %           'ROWS', 20,
    %           'INPUTS', 4,
    %           'GENES_PER_NODE', 3
    %       ))

    % instantiates a vector with the levels back size
    connections = zeros(1, SIZE.LEVELS_BACK);
    
    % iterate through possible node connections
    i = 1;
    for j = this.node_ - SIZE.ROWS:-SIZE.ROWS:SIZE.INPUTS
        if i > SIZE.LEVELS_BACK
            break;
        end
        connections(i) = j;
        i = i + 1;
    end

    % if there are any node connections, initialize the j propertie
    if isempty(j) 
        j = this.node_ - SIZE.ROWS;
    end

    % if the levels back value wasn't reached, fill in with the node inputs
    if j <= SIZE.LEVELS_BACK
        for j = SIZE.INPUTS:-1:1
            if i > SIZE.LEVELS_BACK
                break;
            end
            connections(i) = j;
            i = i + 1;
        end
    end

    % sort the connections
    % remove the zeros
    % remove duplicates
    connections = sort(connections(connections > 0));
    difference  = diff([connections,NaN]);
    connections = connections(difference~=0);
end
