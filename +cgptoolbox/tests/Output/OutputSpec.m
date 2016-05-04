classdef OutputSpec < matlab.unittest.TestCase
    
    methods (Test)

        % should return the value passed to Output
        function testClass(testCase)
            context = Output(30);
            testCase.verifyClass(context, 'Output');
        end

        function testInteger(testCase)
            actSolution = Output(1).get();
            expSolution = 1;
            testCase.verifyEqual(actSolution, expSolution);
            
            actSolution = Output(2).get();
            expSolution = 2;
            testCase.verifyEqual(actSolution, expSolution);
        end
        
        function testDecimalInput(testCase)
            testCase.verifyError(@()Output(2.46), 'CGP:OUTPUT:InputMustNotBeDecimal');
        end
        
        function testNull(testCase)
            testCase.verifyError(@()Output(), 'MATLAB:minrhs');
        end

        function testString(testCase)
            testCase.verifyError(@()Output(''), 'CGP:OUTPUT:InputMustBeIntegerOrDouble');
        end
    end
end