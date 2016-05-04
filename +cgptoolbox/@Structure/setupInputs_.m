function setupInputs_(this, INPUTS)
    % setupInputs_ Setup the input genes array
    %
    %   Input:
    %       this   {Structure} instante of the class
    %       INPUTS {integer} number of CGP inputs
    %
    %   Examples:
    %       structure.setupInputs_(4)
    %       structure.setupInputs_(2)

    this.INPUTS = 1:INPUTS;
end
