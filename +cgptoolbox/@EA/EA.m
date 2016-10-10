classdef EA < handle

    properties (Access = private)
        configuration_
        fittestSolution_
        solutionsOfAllRuns_
    end

    methods (Access = public)

        function this = EA (vararg)
            this.configuration_ = vararg;
            this.initSolutions_();
        end
    end
    
    methods (Access = private)
        
        function updateSolutions_(this, functions, run)
            this.solutionsOfAllRuns_(run).functions = functions;
            this.solutionsOfAllRuns_(run).genes = this.fittestSolution_.getGenes();
            this.solutionsOfAllRuns_(run).active = this.fittestSolution_.getActiveNodes();
            this.solutionsOfAllRuns_(run).fitness = this.fittestSolution_.getFitness();
        end
        
        function initSolutions_(this)
            this.solutionsOfAllRuns_ = repmat( ...
                struct( ...
                    'sizes', this.configuration_.config.sizes, ...
                    'structure', this.configuration_.config.structure, ...
                    'genes', [], ...
                    'active', [], ...
                    'functions', '', ...
                    'fitness', 0 ...
                ), ...
                this.configuration_.config.sizes.runs, 1 ...
            );
        end
    end
end
