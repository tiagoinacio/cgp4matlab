function addFunctionsFromPath(this, path)
    % addFunctionsFromPath Add functions from path to the function-set
    %
    %   Read and assign all functions from the path provided to the function_set propertie of the config_ struct
    %   Assign the number of methods of the function set to the functions constant of the struct sizes_
    %
    %   Input:
    %       this {CGP} instante of the class CGP
    %       path {string} relative or absolute path to the function set directory
    %
    %   Examples:
    %       cgp.addFunctionsFromPath('./my-function-set')

    directoryMethods = dir([path, '/*.m']);
    this.config_.sizes.functions = length(directoryMethods);
    this.functions_ = cell(this.config_.sizes.functions, 1);

    for i = 1:this.config_.sizes.functions
       this.functions_{i} = str2func(directoryMethods(i).name(1:end - 2));
       this.config_.function_set{i} = directoryMethods(i).name(1:end - 2);
    end
end
