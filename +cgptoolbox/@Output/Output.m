classdef Output
    % Output Class
    %   Create output gene
    %
    %   Create an output gene that points to a certain node.
    %   If the output should be the last node, returns the
    %   last node. If not, the output should be randomly selected.
    %
    %   Output Properties:
    %       outputNode_ {Integer} the output node
    %
    %   Output Methods:
    %       get {public} get the output node
    %
    %       validateParameters_ {private} validate the Output parameters

    properties (Access = private)
        configuration_
    end

    methods (Access = public)

        function this = Output(vararg)
            % Output Constructor
            %
            %   Validate the constructor parameters.
            %   Generate the output node according to the `vararg.shouldBeLastNode`
            %
            %   Input:
            %       vararg.numberOfInputs           {integer} number of CGP inputs
            %       vararg.numberOfNodes    {integer} number of nodes in the genotype
            %       vararg.shouldBeLastNode {bool}    if the output should be the last node
            %
            %   Examples:
            %       Output(2, 16, false)
            %       Output(4, 20, true)

            % validate parameters
            if (~isa(vararg.numberOfNodes, 'double') && ~isa(vararg.numberOfNodes, 'integer'))
                error('CGP:OUTPUT:InputMustBeIntegerOrDouble', 'Input must be integer or double.');
            end

            if round(vararg.numberOfNodes) ~= vararg.numberOfNodes
                error('CGP:OUTPUT:InputMustNotBeDecimal', 'Input must not be decimal.');
            end

            if vararg.numberOfNodes < 1
                error('CGP:OUTPUT:InputMustBePositive', 'Input must be positive.');
            end

            if isfield(vararg, 'shouldBeLastNode')
                if ~islogical(vararg.shouldBeLastNode)
                    error('CGP:OUTPUT:shouldBeLastNodeMustBeABoolean', 'The porpertie vararg.shouldBeLastNode, should be a boolean.');
                end
            else
                vararg.shouldBeLastNode = false;
            end
            
            this.configuration_ = vararg;
        end

    end
end
