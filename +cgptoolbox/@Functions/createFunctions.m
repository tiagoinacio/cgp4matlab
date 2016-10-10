function value = createFunctions(this)
    value = randi([1 this.configuration_.sizeOfFunctionSet], 1, this.configuration_.numberOfFunctions);
end