function bool = isThisSolutionFitterThanParent_(this, solutionFitness, fitness_operator)
    % isThisSolutionFitterThanParent_ checks if the new solution is better than the previous
    %
    %   Checks for the fitness value of the previous solution, and the new generated solution.
    %
    %   Output {bool} If the new solution has better fitness, return true.
    %                 If the previous solution has better fitness, return false.
    %
    %   Input:
    %       this {Generation} instante of the class
    %       solutionFitness {Number} fitness value from the new generated solution
    %       solutionFitness {Char} fitness operator to use
    %
    %   Examples:
    %       generation.isThisSolutionFitterThanParent_(10, '>=');
    %       generation.isThisSolutionFitterThanParent_(0.2, '<');

    absolute_value = abs(solutionFitness);
    fitness_solution =  abs(this.fittest_.fitness());
    switch fitness_operator
        case '>='
            bool = absolute_value >= fitness_solution;
        case '<='
            bool = absolute_value <= fitness_solution;
        case '>'
            bool = absolute_value > fitness_solution;
        case '<'
            bool = absolute_value < fitness_solution;
        otherwise
            bool = absolute_value >= fitness_solution;
    end
end
