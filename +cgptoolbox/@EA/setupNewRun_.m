function setupNewRun_(this, CONFIG, SIZE, STRUCTURE, inputs, functions, parameters)
    % setupNewRun_ initialize properties before execute a new run
    %   Initialize the fitness_ vector to all zeros
    %   Instantiate the offsprings
    %   Get the fittest solution from the offsprings
    %   Initialize the current generation to 1
    %
    %   Input:
    %       this       {EA} skip the instance class
    %       CONFIG     {struct} struct constant with configuration values
    %       SIZE       {struct} size related struct constant
    %       STRUCTURE  {Structure} struct constant with genes split into sections
    %       inputs     {array} inputs to the CGP
    %       functions  {array} array of functions of the function-set
    %       parameters {array} parameters to the genotype
    %
    %   Examples:
    %       ea.setupNewRun_(CONFIG, SIZE, STRUCTURE, inputs, functions, parameters);

    this.generation_ = 1;
    this.fitness_    = zeros(1, SIZE.GENERATIONS);
    this.output_(this.run_).functions = functions;

    % setup offsprings
    offsprings       = cgptoolbox.Offsprings(CONFIG, SIZE, STRUCTURE, inputs, functions, parameters);
    this.offsprings_ = offsprings.solutions();
    this.fittest_    = offsprings.fittest();
end
