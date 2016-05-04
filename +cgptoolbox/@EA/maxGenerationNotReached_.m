function bool = maxGenerationNotReached_(this, GENERATIONS)
    % maxGenerationNotReached_ Return true if the maximum generations number was not reached
    %   If the current generation is less than the maximum generations limit, return true.
    %   Otherwise return false.
    %
    %   Output:
    %       bool {bool} true if maximum generation was not reached
    %                   false if the maximum generation was reached
    %
    %   Input:
    %       this            {EA} instance of EA class
    %           generation_ {integer} current generation
    %       GENERATIONS     {Integer} number of maximum generations
    %
    %   Examples:
    %       ea.maxGenerationNotReached(500);
    %       ea.maxGenerationNotReached(1000);

    bool = this.generation_ <= GENERATIONS;
end
