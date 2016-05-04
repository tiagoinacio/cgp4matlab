classdef CGPCGPSpec < matlab.unittest.TestCase

    properties
        mock = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', 1   ... % outputs
        );

        structureSmallerSizeMock = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16 ... % levels_back
        );

        structureBiggerSizeMock = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', 1,   ... % outputs
            'extra', 'something'   ... % extra
        );

        structureWithoutName = struct( ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', 1,   ... % outputs
            'extra', 'something'   ... % extra
        );

        structureWithoutRows = struct( ...
            'name', 'sound-processing', ...
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', 1,   ... % outputs
            'extra', 'something'   ... % extra
        );

        structureWithoutColumns = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'levels_back', 16, ... % levels_back
            'outputs', 1,   ... % outputs
            'extra', 'something'   ... % extra
        );

        structureWithoutLevelsBack = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'outputs', 1,   ... % outputs
            'extra', 'something'   ... % extra
        );

        structureWithoutOutputs = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'extra', 'something'   ... % extra
        );

        structureNameNotString = struct( ...
            'name', 1, ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', 1   ... % outputs
        );

        structureRowsNotInteger = struct( ...
            'name', 'sound-processing', ...
            'rows', '1',  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', 1   ... % outputs
        );

        structureColumnsNotInteger = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', '16', ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', 1   ... % outputs
        );

        structureLevelsBackNotInteger = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', '16', ... % levels_back
            'outputs', 1   ... % outputs
        );

        structureOutputsNotInteger = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', '1'   ... % outputs
        );
    end

    methods (Test)
        
        % test class
        function testClass(testCase)
            context = CGP(testCase.mock);
            testCase.verifyClass(context, 'CGP');
        end

        % testCGP
        function testNumberOfInputs(testCase)
            testCase.verifyError(@()CGP(testCase.mock, 2), 'CGP:CGP:CGPOnlyTakesOneInputStructure');
        end

        function testInputType(testCase)
            testCase.verifyError(@()CGP(2), 'CGP:CGP:InputMustBeAStructure');
        end

        function testStructureSize(testCase)
            testCase.verifyError(@()CGP(testCase.structureBiggerSizeMock), 'CGP:CGP:InvalidSizeOfStructure');
            testCase.verifyError(@()CGP(testCase.structureSmallerSizeMock), 'CGP:CGP:InvalidSizeOfStructure');
        end

        function testStructureKeys(testCase)
            testCase.verifyError(@()CGP(testCase.structureWithoutName), 'CGP:CGP:MissingNameInStructureInput');
            testCase.verifyError(@()CGP(testCase.structureWithoutRows), 'CGP:CGP:MissingRowsInStructureInput');
            testCase.verifyError(@()CGP(testCase.structureWithoutColumns), 'CGP:CGP:MissingColumnsInStructureInput');
            testCase.verifyError(@()CGP(testCase.structureWithoutLevelsBack), 'CGP:CGP:MissingLevelsBackInStructureInput');
            testCase.verifyError(@()CGP(testCase.structureWithoutOutputs), 'CGP:CGP:MissingOutputsInStructureInput');
        end

        function testStructureName(testCase)
            testCase.verifyError(@()CGP(testCase.structureNameNotString), 'CGP:CGP:ProblemNameMustBeAString');
        end

        function testStructureRows(testCase)
            testCase.verifyError(@()CGP(testCase.structureRowsNotInteger), 'CGP:CGP:RowsMustBeAnInteger');

            testCase.structureRowsNotInteger.rows = 2.001;
            testCase.verifyError(@()CGP(testCase.structureRowsNotInteger), 'CGP:CGP:RowsMustBeAnInteger');

            testCase.structureRowsNotInteger.rows = 0.001;
            testCase.verifyError(@()CGP(testCase.structureRowsNotInteger), 'CGP:CGP:RowsMustBeAnInteger');

            testCase.structureRowsNotInteger.rows = -1;
            testCase.verifyError(@()CGP(testCase.structureRowsNotInteger), 'CGP:CGP:RowsMustBePositive');
        end

        function testStructureColumns(testCase)
            testCase.verifyError(@()CGP(testCase.structureColumnsNotInteger), 'CGP:CGP:ColumnsMustBeAnInteger');

            testCase.structureColumnsNotInteger.columns = 2.001;
            testCase.verifyError(@()CGP(testCase.structureColumnsNotInteger), 'CGP:CGP:ColumnsMustBeAnInteger');

            testCase.structureColumnsNotInteger.columns = 0.001;
            testCase.verifyError(@()CGP(testCase.structureColumnsNotInteger), 'CGP:CGP:ColumnsMustBeAnInteger');

            testCase.structureColumnsNotInteger.columns = -1;
            testCase.verifyError(@()CGP(testCase.structureColumnsNotInteger), 'CGP:CGP:ColumnsMustBePositive');
        end

        function testStructureLevelsBack(testCase)
            testCase.verifyError(@()CGP(testCase.structureLevelsBackNotInteger), 'CGP:CGP:LevelsBackMustBeAnInteger');

            testCase.structureLevelsBackNotInteger.levels_back = 2.001;
            testCase.verifyError(@()CGP(testCase.structureLevelsBackNotInteger), 'CGP:CGP:LevelsBackMustBeAnInteger');

            testCase.structureLevelsBackNotInteger.levels_back = 0.001;
            testCase.verifyError(@()CGP(testCase.structureLevelsBackNotInteger), 'CGP:CGP:LevelsBackMustBeAnInteger');

            testCase.structureLevelsBackNotInteger.levels_back = -1;
            testCase.verifyError(@()CGP(testCase.structureLevelsBackNotInteger), 'CGP:CGP:LevelsBackMustBePositive');
        end

        function testStructureOutputs(testCase)
            testCase.verifyError(@()CGP(testCase.structureOutputsNotInteger), 'CGP:CGP:OutputsMustBeAnInteger');

            testCase.structureOutputsNotInteger.outputs = 2.001;
            testCase.verifyError(@()CGP(testCase.structureOutputsNotInteger), 'CGP:CGP:OutputsMustBeAnInteger');

            testCase.structureOutputsNotInteger.outputs = 0.001;
            testCase.verifyError(@()CGP(testCase.structureOutputsNotInteger), 'CGP:CGP:OutputsMustBeAnInteger');

            testCase.structureOutputsNotInteger.outputs = -1;
            testCase.verifyError(@()CGP(testCase.structureOutputsNotInteger), 'CGP:CGP:OutputsMustBePositive');
        end
    end
end
