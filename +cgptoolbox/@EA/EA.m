classdef EA < handle

    properties (Access = private)
        fittestSolution_
        solutionsOfAllRuns_
    end

    methods (Access = public)

        function this = EA (vararg)

            this.initSolutions_(vararg.config);
        
            while (vararg.config.run <= vararg.config.sizes.runs)

                this.fittestSolution_ = cgptoolbox.Run(vararg).getFittestSolution();

                if isfield(vararg.callbacks, 'NEW_RUN')
                    vararg.callbacks.NEW_RUN(struct( ...
                        'name', 'NEW_RUN', ...
                        'run', vararg.config.run, ...
                        'fitness', this.fittestSolution_.getFitness(), ...
                        'genes', this.fittestSolution_.getGenes(), ...
                        'activeNodes', this.fittestSolution_.getActiveNodes() ...
                    ));
                end
                
                this.updateSolutions_(vararg.functionSet, vararg.config.run)
                
                vararg.config.run = vararg.config.run + 1;
            end
        end
    end
    
    methods (Access = private)
        
        function updateSolutions_(this, functions, run)
            this.solutionsOfAllRuns_(run).functions = functions;
            this.solutionsOfAllRuns_(run).genes = this.fittestSolution_.getGenes();
            this.solutionsOfAllRuns_(run).active = this.fittestSolution_.getActiveNodes();
            this.solutionsOfAllRuns_(run).fitness = this.fittestSolution_.getFitness();
        end
        
        function initSolutions_(this, config)
            this.solutionsOfAllRuns_ = repmat( ...
                struct( ...
                    'sizes', config.sizes, ...
                    'structure', config.structure, ...
                    'genes', [], ...
                    'active', [], ...
                    'functions', '', ...
                    'fitness', 0 ...
                ), ...
                config.sizes.runs, 1 ...
            );
        end
    end
end
