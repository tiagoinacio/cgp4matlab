function solutions_ = run(this)
    % train Run the algorithm
    %
    %   Configure a few properties to run the algorithm
    %   Run the evolutionary algorithm
    %
    %   Input:
    %       this {CGP} instante of the class CGP
    %
    %   Examples:
    %   cgp.train()

    this.configuration_();

    ea_ = cgptoolbox.EA (struct( ...
        'config', this.config_, ...
        'programInputs', this.inputs_, ...
        'functionSet', {this.functions_}, ...
        'parameters', {this.parameters_}, ...
        'callbacks', this.callbacks_ ...
    ));

    solutions_ = ea_.getSolutions();
end
