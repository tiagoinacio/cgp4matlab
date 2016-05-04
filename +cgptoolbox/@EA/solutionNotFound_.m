function notFound = solutionNotFound_(this, solution_fitness)
    % solutionNotFound_ check if a solution is a valid solution or not
    %   
    %   If the absolute value of the fittest's fitness solution is less
    %   then the minimum fitness for a valid solution, returns true.
    %   If the fitness is bigger than the threshold `solution_fitness`,
    %   returns false.
    %
    %   Input:
    %       this             {EA} instance of EA class
    %           fittest_ {Genotype} fittest solution
    %       solution_fitness {struct} struct constant with configuration values
    %
    %   Examples:
    %       ea.solutionNotFound_(0.01);
    %       ea.solutionNotFound_(0.1);

    if (abs(this.fittest_.fitness()) >= solution_fitness)
        notFound = false;
    else
        notFound = true;
    end
end
