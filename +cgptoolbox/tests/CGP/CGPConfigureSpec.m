classdef CGPConfigureSpec < matlab.unittest.TestCase

    properties
        cgpMock = struct( ...
            'name', 'sound-processing', ...
            'rows', 1,  ... % rows
            'columns', 16, ... % columns
            'levels_back', 16, ... % levels_back
            'outputs', 1   ... % outputs
        );

        structureMock = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureSmallerSizeMock = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1  ... % mutation
        );

        structureBiggerSizeMock = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'mutation2', 0.1,  ... % mutation
            'mutation3', 0.1  ... % mutation
        );

        structureWithoutRuns = struct( ...
            'fake_runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureWithoutGenerations = struct( ...
            'runs', 1,    ... % runs
            'fake_generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureWithoutPopulation = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'fake_population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureWithoutMutation = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'fake_mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureWithoutMinFitness = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fake_fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureRunsNotInteger = struct( ...
            'runs', '1',    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureRunsNotPositive = struct( ...
            'runs', -3,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureGenerationsNotInteger = struct( ...
            'runs', 1,    ... % runs
            'generations', '1000', ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureGenerationsNotPositive = struct( ...
            'runs', 1,    ... % runs
            'generations', -1, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structurePopulationNotInteger = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', '4',    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structurePopulationNotPositive = struct( ...
            'runs', 1,    ... % runs
            'generations', 1, ... % generations
            'population', -4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureMutationNotNumber = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', '0.1',  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureMutationNotPositive = struct( ...
            'runs', 1,    ... % runs
            'generations', 1, ... % generations
            'population', 4,    ... % population
            'mutation', -1,  ... % mutation
            'fitness_solution', 0.01  ... % min fitness to solution found
        );

        structureMinFitnessNotNumber = struct( ...
            'runs', 1,    ... % runs
            'generations', 1000, ... % generations
            'population', 4,    ... % population
            'mutation', 0.1,  ... % mutation
            'fitness_solution', '0.01'  ... % min fitness to solution found
        );

        structureMinFitnessNotPositive = struct( ...
            'runs', 1,    ... % runs
            'generations', 1, ... % generations
            'population', 4,    ... % population
            'mutation', 1,  ... % mutation
            'fitness_solution', -0.01  ... % min fitness to solution found
        );
    end

    methods (Test)

        function testNumberOfInputs(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(1, 2), 'MATLAB:TooManyInputs' ...
            );
        end

        function testInputType(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(1), 'CGP:Configure:InputMustBeAStructure' ...
            );
        end

        function testStructureSize(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureBiggerSizeMock), 'CGP:Configure:InvalidSizeOfStructure' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureSmallerSizeMock), 'CGP:Configure:InvalidSizeOfStructure' ...
            );
        end

        function testStructureKeys(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureWithoutRuns), 'CGP:Configure:MissingRunsInStructureInput' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureWithoutGenerations), 'CGP:Configure:MissingGenerationsInStructureInput' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureWithoutPopulation), 'CGP:Configure:MissingPopulationInStructureInput' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureWithoutMutation), 'CGP:Configure:MissingMutationInStructureInput' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureWithoutMinFitness), 'CGP:Configure:MissingMinimumFitnessInStructureInput' ...
            );
        end

        function testStructureRuns(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureRunsNotInteger), 'CGP:Configure:RunsMustBeAnInteger' ...
            );

            structureRunsNotInteger = 2.001;
            testCase.verifyError( ...
                @()cgp.configure(testCase.structureRunsNotInteger), 'CGP:Configure:RunsMustBeAnInteger' ...
            );

            structureRunsNotInteger = 0.001;
            testCase.verifyError( ...
                @()cgp.configure(testCase.structureRunsNotInteger), 'CGP:Configure:RunsMustBeAnInteger' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureRunsNotPositive), 'CGP:Configure:RunsMustBePositive' ...
            );
        end

        function testStructureGenerations(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureGenerationsNotInteger), 'CGP:Configure:GenerationsMustBeAnInteger' ...
            );

            structureGenerationsNotInteger = 2.001;
            testCase.verifyError( ...
                @()cgp.configure(testCase.structureGenerationsNotInteger), 'CGP:Configure:GenerationsMustBeAnInteger' ...
            );

            structureGenerationsNotInteger = 0.001;
            testCase.verifyError( ...
                @()cgp.configure(testCase.structureGenerationsNotInteger), 'CGP:Configure:GenerationsMustBeAnInteger' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureGenerationsNotPositive), 'CGP:Configure:GenerationsMustBePositive' ...
            );
        end

        function testStructurePopulation(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(testCase.structurePopulationNotInteger), 'CGP:Configure:PopulationMustBeAnInteger' ...
            );

            structurePopulationNotInteger = 2.001;
            testCase.verifyError( ...
                @()cgp.configure(testCase.structurePopulationNotInteger), 'CGP:Configure:PopulationMustBeAnInteger' ...
            );

            structurePopulationNotInteger = 0.001;
            testCase.verifyError( ...
                @()cgp.configure(testCase.structurePopulationNotInteger), 'CGP:Configure:PopulationMustBeAnInteger' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structurePopulationNotPositive), 'CGP:Configure:PopulationMustBePositive' ...
            );
        end

        function testStructureMutation(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureMutationNotNumber), 'CGP:Configure:MutationMustBeANumber' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureMutationNotPositive), 'CGP:Configure:MutationMustBePositive' ...
            );
        end

        function testStructureMinFitness(testCase)
            cgp = CGP(testCase.cgpMock);

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureMinFitnessNotNumber), 'CGP:Configure:MinFitnessMustBeANumber' ...
            );

            testCase.verifyError( ...
                @()cgp.configure(testCase.structureMinFitnessNotPositive), 'CGP:Configure:MinFitnessMustBePositive' ...
            );
        end
    end
end

