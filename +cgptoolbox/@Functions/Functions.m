classdef Functions
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
        configuration_
    end

    methods (Access = public)

        function this = Functions(vararg)
            % Function Constructor
            %
            %   Input:
            %       vararg.sizeOfFunctionSet {integer} number of functions present in the function-set
            %       vararg.numberOfFunctions {integer} number of functions to generate
            %
            %   Examples:
            %       Function(10, 1)
            %       Function(5, 5)
            this.configuration_ = vararg;
        end
    end
end
