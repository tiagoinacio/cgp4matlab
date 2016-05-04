classdef Connection
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
    %       Connection(SIZE, 10)

    properties (Access = private)
        value_
        node_
        connections_
    end

    methods (Access = public)
        
        function this = Connection(SIZE, gene)
            % Connection Class - create a connection node
            %
            %   Find the current node that needs a connection
            %   Find all the possible node connections (including the
            %   inputs)
            %   Select a random connection
            %
            % 	Input:
            %   SIZE {struct}  struct with constants refleting the number of
            %                  levels back, rows, inputs and genes per node.
            %   gene {integer} gene index that belongs to the current node
            %
            % 	Examples:
            %   Connection(struct(
            %       'LEVELS_BACK', 16,
            %       'INPUTS', 4,
            %       'ROWS', 16,
            %       'GENES_PER_NODE', 3,
            %   ), 10)
            %    
            %   Connection(struct(
            %       'LEVELS_BACK', 5,
            %       'INPUTS', 2,
            %       'ROWS', 10,
            %       'GENES_PER_NODE', 3,
            %   ), 8)
            
            this.node_ = this.findWhichNodeBelongs_(SIZE, gene);
            this.connections_ = this.findPossibleConnections_(SIZE);
            this.value_ = this.connections_(randi(size(this.connections_, 2)));
        end
    end
end