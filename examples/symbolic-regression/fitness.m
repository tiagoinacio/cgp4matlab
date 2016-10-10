function score = fitness(args) % sizes, structure, genes, activeNodes, programInputs, functionSet, run, generation)
    score = 0.0;
    values = zeros(1, args.config.sizes.nodes);

    % for each data point or test case
    for j = 1:50
        values(1) = args.programInputs.points.x(j);

        % iterate through active nodes
        for i = args.config.sizes.inputs + 1:size(args.activeNodes, 2)
            % get current active node that we want to decode
            currentActiveNode = args.activeNodes(i);

            % get the gene that points to the function-gene of the active node
            functionGeneOfActiveNode = args.config.structure.functionGenes(currentActiveNode - args.config.sizes.inputs);

            % get the function gene of the active node
            currentFunctionGene = args.genes(functionGeneOfActiveNode);

            % get the genes index
            geneFirstConnection = args.config.structure.connectionGenes{1}(currentActiveNode - args.config.sizes.inputs);
            geneSecondConnection = args.config.structure.connectionGenes{2}(currentActiveNode - args.config.sizes.inputs);

            % get the nodes index
            nodeFirstConnection = args.genes(geneFirstConnection);
            nodeSecondConnection = args.genes(geneSecondConnection);

            % get the values of the connections
            firstConnection = values(nodeFirstConnection);
            secondConnection = values(nodeSecondConnection);

            % find how many genes per node
            % genesPerNode = 3 + args.config.sizes.parameters;

            % genes of the active node
            % lastParameter = currentActiveNode * genesPerNode;

            % gene of the first parameter
            %firstParameter = lastParameter - args.config.sizes.parameters + 1;

            %allParameters = firstParameter:lastParameter;
            %for k = 1:size(allParameters, 2)
            %    parameters(k) = args.genes(allParameters(k));
            %end

            % call the function which index is given by currentFunctionGene
            values(currentActiveNode) = args.functionSet{currentFunctionGene}(firstConnection, secondConnection);
        end

        % compute the sum of squared error
        score = score + abs(values(args.activeNodes(end)) - args.programInputs.points.y(j));
    end
end
