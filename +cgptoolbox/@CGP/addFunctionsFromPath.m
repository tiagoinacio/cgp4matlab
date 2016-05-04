function addFunctionsFromPath(this, path)
    % addFunctionsFromPath Add functions from path to the function-set
    %
    %   Read and assign all functions from the path provided to the function_set propertie of the CONFIG_ struct
    %   Assign the number of methods of the function set to the FUNCTIONS constant of the struct SIZE_
    %
    %   Input:
    %       this {CGP} instante of the class CGP
    %       path {string} relative or absolute path to the function set directory
    %
    %   Examples:
    %       cgp.addFunctionsFromPath('./my-function-set')

    directoryMethods = dir([path, '/*.m']);
    this.SIZE_.FUNCTIONS = length(directoryMethods);
    this.functions_ = cell(this.SIZE_.FUNCTIONS, 1);

    for i = 1:this.SIZE_.FUNCTIONS
       this.functions_{i} = str2func(directoryMethods(i).name(1:end - 2));
       this.CONFIG_.function_set{i} = directoryMethods(i).name(1:end - 2);
    end
end
