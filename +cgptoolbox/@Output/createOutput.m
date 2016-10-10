function value = createOutput(this)
    if this.configuration_.shouldBeLastNode
        % assign the output to the last node of the genotype
        value = this.configuration_.numberOfNodes;
    else
        % assign a random node as the output
        value = randi([1, this.configuration_.numberOfNodes]);
    end
end
