classdef ParameterSpec < matlab.unittest.TestCase
    
    properties
        parametersMock = struct( ...
            'name', 'gaussfilter-sigma', ...
            'type', 'int', ...
            'minValue', 1, ...
            'maxValue', 10 ...
        );

        parametersWithoutTypeMock = struct( ...
            'name', 'gaussfilter-sigma', ...
            'minValue', 1, ...
            'maxValue', 10 ...
        );

        parametersWithoutMinValueMock = struct( ...
            'name', 'gaussfilter-sigma', ...
            'type', 'int', ...
            'maxValue', 10 ...
        );

        parametersWithoutMaxValueMock = struct( ...
            'name', 'gaussfilter-sigma', ...
            'type', 'int', ...
            'minValue', 1 ...
        );
    end

    methods (Test)

        % should return the value passed to Output
        function testClass(testCase)
            mock{1} = testCase.parametersMock;
            context = Parameter(mock, 1);
            testCase.verifyClass(context, 'Parameter');
        end

        % test gene input
        function testStringGene(testCase)
            mock{1} = testCase.parametersMock;
            testCase.verifyError(@()Parameter(mock, ''), 'CGP:PARAMETER:GeneMustBeIntegerOrDouble');
        end
        
        function testDecimalGene(testCase)
            mock{1} = testCase.parametersMock;
            testCase.verifyError(@()Parameter(mock, 1.0001), 'CGP:PARAMETER:GeneMustNotBeDecimal');
        end

        function testNegativeGene(testCase)
            mock{1} = testCase.parametersMock;
            testCase.verifyError(@()Parameter(mock, -1), 'CGP:PARAMETER:GeneMustBePositive');
        end

        function testMaxGeneIndex(testCase)
            mock{1} = testCase.parametersMock;
            testCase.verifyError(@()Parameter(mock, 2), 'CGP:PARAMETER:GeneMustBeAValidIndex');
            
            mock{2} = testCase.parametersMock;
            Parameter(mock, 2).get();
        end
        
        function testParameterWithoutType(testCase)
            mock{1} = testCase.parametersWithoutTypeMock;
            testCase.verifyError(@()Parameter(mock, 1), 'CGP:PARAMETER:ParameterMustHaveAType');
        end
        
        function testParameterWithoutMinValue(testCase)
            mock{1} = testCase.parametersWithoutMinValueMock;
            testCase.verifyError(@()Parameter(mock, 1), 'CGP:PARAMETER:ParameterMustHaveAMinimumValue');
        end

        function testParameterWithoutMaxValue(testCase)
            mock{1} = testCase.parametersWithoutMaxValueMock;
            testCase.verifyError(@()Parameter(mock, 1), 'CGP:PARAMETER:ParameterMustHaveAMaximumValue');
        end

        % test parameters input
        function testMaxParameterValue(testCase)
            mock{1} = testCase.parametersMock;
            actSolution = Parameter(mock, 1).get();
            testCase.verifyLessThan(actSolution, 10);
        end

        function testMinParameterValue(testCase)
            mock{1} = testCase.parametersMock;
            actSolution = Parameter(mock, 1).get();
            testCase.verifyGreaterThan(actSolution, 1);
        end

         function testNull(testCase)
             mock{1} = testCase.parametersMock;
             testCase.verifyError(@()Parameter(mock), 'MATLAB:minrhs');
         end
 
    end
end