function bool = isThisSolutionFitterThanParent_(this, solutionFitness)
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
    %
    %   Examples:
    %       generation.isThisSolutionFitterThanParent_(10);
    %       generation.isThisSolutionFitterThanParent_(0.2);

    bool = abs(solutionFitness) >= abs(this.fittest_.fitness());
end
