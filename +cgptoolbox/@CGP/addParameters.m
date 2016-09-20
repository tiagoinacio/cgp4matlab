function addParameters(this, varargin)
    % addParameters Add parameters to the genotype
    %
    %   Validate the parameters provided
    %   Assign the parameters (varargin) to the parameters_ private propertie
    %   Assign the number of parameters to the parameters constant of the sizes_ struct
    %
    %   Input:
    %       this     {CGP} instante of the class CGP
    %       varargin {struct} struct of variable size which contains the parameteres to the CGP
    %           'name'     {string} name of the parameter
    %           'type'     {string} type of the parameter [string, int, float, double, ...]
    %           'minValue' {number} - minimum value for the parameter
    %           'maxValue' {number} - maximum value for the parameter
    %
    %   Examples:
    %       cgp.addParameters(struct(
    %           'name', 'parameter-name',
    %           'type', 'int',
    %           'minValue', 1,
    %           'maxValue', 10
    %       ),
    %       struct(
    %           'name', 'other-parameter-name',
    %            'type', 'int',
    %            'minValue', 50,
    %             'maxValue', 200
    %         )
    %       );
    %
    %       cgp.addParameters(struct(
    %           'name', 'parameter-name',
    %           'type', 'int',
    %           'minValue', 1,
    %           'maxValue', 10
    %       ))
    %
    %      cgp.addParameters(my-first-paremeter-struct, my-second-paremeter-struct, ...)

    if this.areValidParameters_(varargin);
        this.parameters_ = varargin;
        this.config_.sizes.parameters = length(varargin);
    end
end
