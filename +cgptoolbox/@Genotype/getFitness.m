function fitness_ = getFitness(this)
    % genes Return the fitness of this genotype
    %
    %   Input:
    %       this {Genotype} instante of the class
    %
    %   Examples:
    %       genotype.fitness()

    fitness_ = this.fitness_.get();
end
