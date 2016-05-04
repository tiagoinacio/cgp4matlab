function addCallbacks(this, callbacks)
    % addCallbacks Add callbacks to each section of the algorithm
    %
    %   Assign the callbacks to the `callbacks_` private propertie
    %
    %   Input:
    %       this      {CGP} instante of the class CGP
    %       callbacks {struct} with function handles for each callback
    %
    %   Examples:
    %       cgp.addCallbacks(struct(
    %           'CONFIGURATION', @my-configuration-callback-fn,
    %           'RUN', @my-run-callback-fn,
    %           'GENERATION', @my-generation-callback-fn,
    %           'GENOTYPE', @my-genotype-callback-fn,
    %           'GENOTYPE_MUTATED', @my-genotype-mutated-callback-fn
    %       ))

    this.callbacks_ = callbacks;
end
