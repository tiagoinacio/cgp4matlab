classdef Function
    % Function Class
    %   Selects a function from the function-set
    %
    %   The Function class randomly selects a function
    %   based on the number of functions present in the function-set
    %
    %   Fitness Properties:
    %       value_ {Number} function index
    %
    %   Fitness Methods:
    %       get - get the function index

    properties (Access = private)
        value_
    end

    methods (Access = public)

        function this = Function(sizeOfFunctionSet, numberOfFunctions)
            % Function Constructor
            %
            %   Input:
            %       sizeOfFunctionSet {integer} number of functions present in the function-set
            %       numberOfFunctions {integer} number of functions to generate
            %
            %   Examples:
            %       Function(10, 1)
            %       Function(5, 5)
            this.value_ = randi([1 sizeOfFunctionSet], 1, numberOfFunctions);
        end
    end
end
