function validateParameters_(~, params)
 
    for i = 1:length(params)
        if length(fieldnames(params{i})) ~= 3
            error( ...
                'CGP:CGP_PARAMETERS_ERROR', ...
                '\nPlease configure your parameters with a struct:\n\n\t%s\n\t%s\n\t%s\n', ...
                'name: type string', ...
                'initialize: function handle which creates the initial value of the parameter', ...
                'mutate: function handle which mutates the value of the parameter' ...
            );
        end
    end

end