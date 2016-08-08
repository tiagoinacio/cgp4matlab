function addInputs(this, varargin)
    % addInputs Add inputs for the problem
    %
    %   Assign the inputs (varargin{1}) to the inputs_ private propertie
    %   Assign the number of inputs to the INPUTS constant of the SIZE_ struct
    %
    %   Input:
    %       this {CGP} instante of the class CGP
    %       varargin {struct} struct of variable size which contains the inputs to the CGP
    %
    %   Examples:
    %       cgp.addInputs(struct(
    %           'a', 1,
    %           'b', 2,
    %           'c', 3
    %       ))
    %
    %       cgp.addInputs(struct(
    %           'a', otherStruct,
    %           'b', someArray,
    %           'c', anInteger
    %           ...
    %       ))

    this.SIZE_.INPUTS = length(fieldnames(varargin{1}));
    this.inputs_ = varargin{1};
end
