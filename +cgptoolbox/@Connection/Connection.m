classdef Connection < handle
    % Connection Class
    %   Creates a connection input for the current node
    %
    %   The Connection constructor is responsible for generate a random
    %   valid connection, according to the gene passed by argument.
    %   Connection genes from one node, should only point to nodes in the
    %   range of the levels back. Connection genes should not point to the
    %   node itself or the nodes after.
    %
    %   Connection Properties:
    %       value_       {integer} the connection node selected
    %       node_        {integer} the current node
    %       connections_ {array} array of possible node connections
    %
    %   Connection Methods:
    %       get - return the connection node generated
    %
    %   Examples:
    %       Connection(sizes, 10)

    properties (Access = private)
        configuration_
        newConnection_
        nodeIndex_
        possibleConnections_
    end

    methods (Access = public)

        function this = Connection(vararg)
            % Connection Class - create a connection node
            %
            %   Find the current node that needs a connection
            %   Find all the possible node connections (including the
            %   inputs)
            %   Select a random connection
            %
            % 	Input:
            %   vararg.sizes {struct}  struct with constants refleting the number of
            %                  levels back, rows, inputs and genes per node.
            %   vararg.geneIndex {integer} gene index that belongs to the current node
            %
            % 	Examples:
            %   Connection(struct(
            %       'levels_back', 16,
            %       'inputs', 4,
            %       'rows', 16,
            %       'genes_per_node', 3,
            %   ), 10)
            %
            %   Connection(struct(
            %       'levels_back', 5,
            %       'inputs', 2,
            %       'rows', 10,
            %       'genes_per_node', 3,
            %   ), 8)

            this.configuration_ = vararg;
        end
    end
    
    methods (Access = private)
        function connections = findPossibleConnections_(this)
            % findPossibleConnections_ Find all nodes before the current one, plus the inputs for the CGP
            %
            %   Given a specific node form the genotype, get a list of all possible node connections
            %   The list should have all the nodes before the current one, while in the range of the levels_back parameter
            %       Instantiates a vector with the levels back sizes
            %       Checks if there are any possible node connections, within the
            %       same row
            %       If the levels back is still not reached, find the possible
            %       node inputs
            %
            %   Input:
            %       this {Connection} instance of the Connection class
            %           'node_' - propertie which stores an integer, representing the current node
            %       sizes {struct} struct with sizes related constants
            %           'levels_back'    {integer} number of the previous nodes, which a node can connect to
            %           'rows'           {integer} number of rows
            %           'inputs'         {integer} number of CGP inputs
            %           'genes_per_node' {integer} number of genes per node (connection genes + function gene + parameters)
            %
            %   Examples:
            %       cgp.findPossibleConnections_(struct(
            %           'levels_back', 16,
            %           'rows', 16,
            %           'inputs', 2,
            %           'genes_per_node', 5
            %       ))
            %
            %       cgp.findPossibleConnections_(struct(
            %           'levels_back', 10,
            %           'rows', 20,
            %           'inputs', 4,
            %           'genes_per_node', 3
            %       ))

            % instantiates a vector with the levels back sizes
            connections = zeros(1, this.configuration_.sizes.levels_back);

            % iterate through possible node connections
            i = 1;
            for j = this.nodeIndex_ - this.configuration_.sizes.rows:-this.configuration_.sizes.rows:this.configuration_.sizes.inputs
                if i > this.configuration_.sizes.levels_back
                    break;
                end
                connections(i) = j;
                i = i + 1;
            end

            % if there are any node connections, initialize the j propertie
            if isempty(j)
                j = this.nodeIndex_ - this.configuration_.sizes.rows;
            end

            % if the levels back value wasn't reached, fill in with the node inputs
            if j <= this.configuration_.sizes.levels_back
                for j = this.configuration_.sizes.inputs:-1:1
                    if i > this.configuration_.sizes.levels_back
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
        
        function node = findWhichNodeBelongs_(this)
            % findWhichNodeBelongs_ Find the node which a given gene belongs to
            %
            %   Given a specific gene, find which node belongs to
            %   Since the gene contains the CGP inputs plus the genotype genes,
            %   one must find first the node which belongs to in the genotype, and
            %   add the CGP node inputs.
            %
            %   Input:
            %       ~    {void} skip the Connection class instance
            %       sizes {struct} struct with sizes related constants
            %           'inputs'         { integer} number of CGP inputs
            %           'genes_per_node' { integer} number of genes per node (connection genes + function gene + parameters)
            %       gene {integer} gene which needs to be checked
            %
            %   Examples:
            %       cgp.findWhichNodeBelongs_(struct(
            %           'inputs', 2,
            %           'genes_per_node', 5
            %       ), 10)
            %
            %       cgp.findWhichNodeBelongs_(struct(
            %           'inputs', 4,
            %           'genes_per_node', 3
            %       ), 5)

            node = ceil(this.configuration_.geneIndex / this.configuration_.sizes.genes_per_node);
        end


    end
end
