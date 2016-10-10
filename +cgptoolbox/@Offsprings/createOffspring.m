function createOffspring(this)
    % create one genotype
    genotype = cgptoolbox.Genotype(this.configuration_);
    
    this.fittestSolution_ = genotype.createGenotype();

    % create the rest of the genotypes
    for i = 1:this.configuration_.config.sizes.offsprings - 1
        genotype = cgptoolbox.Genotype(this.configuration_);
                
        this.candidateSolutions_{i} = genotype.createGenotype();;

        absolute_value = this.candidateSolutions_{i}.getFitness();
        fitness_solution = this.fittestSolution_.getFitness();
        switch this.configuration_.config.fitness_operator
            case '>='
                if absolute_value >= fitness_solution
                    this.fittestSolution_ = this.candidateSolutions_{i};
                end
            case '<='
                if absolute_value <= fitness_solution
                    this.fittestSolution_ = this.candidateSolutions_{i};
                end
            case '>'
                if absolute_value > fitness_solution
                    this.fittestSolution_ = this.candidateSolutions_{i};
                end
            case '<'
                if absolute_value < fitness_solution
                    this.fittestSolution_ = this.candidateSolutions_{i};
                end
            otherwise
                if absolute_value >= fitness_solution
                    this.fittestSolution_ = this.candidateSolutions_{i};
                end
        end
    end
end

