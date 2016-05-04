classdef Output
    % Output Class
    %   Create output gene
    %
    %   Create an output gene that points to a certain node.
    %   If the output should be the last node, returns the
    %   last node. If not, the output should be randomly selected.
    %
    %   Output Properties:
    %       value_ {Integer} the output node
    %
    %   Output Methods:
    %       get {public} get the output node
    %
    %       validateParameters_ {private} validate the Output parameters

    properties (Access = private)
        value_
    end

    methods (Access = public)

        function this = Output(INPUTS, numberOfNodes, shouldBeLastNode)
            % Output Constructor
            %
            %   Validate the constructor parameters.
            %   Generate the output node according to the `shouldBeLastNode`
            %
            %   Input:
            %       INPUTS           {integer} number of CGP inputs
            %       numberOfNodes    {integer} number of nodes in the genotype
            %       shouldBeLastNode {bool}    if the output should be the last node
            %
            %   Examples:
            %       Output(2, 16, false)
            %       Output(4, 20, true)

            % validate parameters
            this.validateParameters_(numberOfNodes, shouldBeLastNode);

            if shouldBeLastNode
                % assign the output to the last node of the genotype
                this.value_ = numberOfNodes;
            else
                % assign a random node as the output
                this.value_ = randi([INPUTS + 1, numberOfNodes]);
            end
        end

    end
end
