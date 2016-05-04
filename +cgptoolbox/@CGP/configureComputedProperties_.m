function configureComputedProperties_(this)
    % configureComputedProperties Configure SIZE_ and STRUCTURE_ properties
    %
    %   Configure multiple SIZE_ related properties
    %   Instantiates a Structure object
    %   Fire the CONFIGURATION callback
    %
    %   Input:
    %       this {CGP} instante of the class CGP
    %
    %   Examples:
    %       cgp.configureComputedProperties_()

    this.SIZE_.CONNECTION_NODES = this.SIZE_.ROWS * this.SIZE_.COLUMNS;

    % configure nodes and genes
    this.SIZE_.GENES_PER_NODE = this.SIZE_.CONNECTION_GENES + this.SIZE_.PARAMETERS + 1;
    this.SIZE_.GENES = this.SIZE_.CONNECTION_NODES * this.SIZE_.GENES_PER_NODE + this.SIZE_.INPUTS + this.SIZE_.OUTPUTS;
    this.SIZE_.NODES = this.SIZE_.CONNECTION_NODES + this.SIZE_.INPUTS;

    % configure genotype
    this.STRUCTURE_ = cgptoolbox.Structure( ...
        this.SIZE_.INPUTS, ...
        this.SIZE_.GENES, ...
        this.SIZE_.GENES_PER_NODE, ...
        this.SIZE_.CONNECTION_GENES, ...
        this.SIZE_.CONNECTION_NODES, ...
        this.SIZE_.PARAMETERS ...
    );

    if isfield(this.callbacks_, 'CONFIGURATION')
        this.callbacks_.CONFIGURATION(this.CONFIG_, this.SIZE_);
    end
end
