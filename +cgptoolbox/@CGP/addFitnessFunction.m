function addFitnessFunction(this, fnHandler)
    % addFitnessFunction Add fitness function handler
    %
    %   Assign the fitness function handle to the private propertie fitness_function of the CONFIG struct
    %
    %   Input:
    %       this      {CGP} instante of the class CGP
    %       fnHandler {Handle} fitness function handle
    %
    %   Examples:
    %       cgp.addFitnessFunction(@my-fitness-function)

    this.config_.fitness_function = fnHandler;
end
