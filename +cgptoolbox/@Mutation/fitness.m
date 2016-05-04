function fitness_ = fitness(this)
    % genes Return the fitness of this genotype
    %
    %   Input:
    %       this {Mutation} instante of the class
    %
    %   Examples:
    %       mutation.fitness()

    fitness_ = this.fitness_.get();
end
