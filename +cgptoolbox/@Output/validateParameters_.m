function validateParameters_(~, numberOfNodes, shouldBeLastNode)
    % validateParameters_ Validate the output parameters
    %
    %   Validate the parameters according to this specs:
    %       The numberOfNodes should be an integer or doule.
    %       The numberOfNodes should not be decimal.
    %       The numberOfNodes should not be positive.
    %       The shouldBeLastNode should not be a boolean.
    %
    %   Input:
    %       ~ {void} instante of the class
    %       numberOfNodes {Integer} the number of nodes in the genotype
    %       shouldBeLastNode {bool} if the output should be the last genotype's node
    %
    %   Examples:
    %       output.validateParameters_(16, 1);
    %       output.validateParameters_(14, 0);


    if (~isa(numberOfNodes, 'double') && ~isa(numberOfNodes, 'integer'))
        error('CGP:OUTPUT:InputMustBeIntegerOrDouble', 'Input must be integer or double.');
    end

    if round(numberOfNodes) ~= numberOfNodes
        error('CGP:OUTPUT:InputMustNotBeDecimal', 'Input must not be decimal.');
    end

    if numberOfNodes < 1
        error('CGP:OUTPUT:InputMustBePositive', 'Input must be positive.');
    end

    if ~islogical(shouldBeLastNode)
        error('CGP:OUTPUT:ShouldBeLastNodeMustBeABoolean', 'The porpertie shouldBeLastNode, should be a boolean.');
    end
end
