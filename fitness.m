function score = fitness(sizes, structure, genes, activeNodes, programInputs, functionSet, run, generation)

    score = 0.0;
    values = zeros(1, sizes.NODES);

    % for each data point or test case
    for j = 1:50
        values(1) = programInputs.points.x(j);
        values(2) = programInputs.scalar;

        % iterate through active nodes
        for i = sizes.INPUTS + 1:size(activeNodes, 2)
            % get current active node that we want to decode
            currentActiveNode = activeNodes(i);

            % get the gene that points to the function-gene of the active node
            functionGeneOfActiveNode = structure.FUNCTIONS(currentActiveNode);

            % get the function gene of the active node
            currentFunctionGene = genes(functionGeneOfActiveNode);

            % get the genes index
            geneFirstConnection = structure.CONNECTIONS{1}(currentActiveNode);
            geneSecondConnection = structure.CONNECTIONS{2}(currentActiveNode);
            
            % get the nodes index
            nodeFirstConnection = genes(geneFirstConnection);            
            nodeSecondConnection = genes(geneSecondConnection);
            
            % get the values of the connections
            firstConnection = values(nodeFirstConnection);
            secondConnection = values(nodeSecondConnection);

            % find how many genes per node
            genesPerNode = 3 + sizes.PARAMETERS;

            % find how many nodes are before the current node in the genotype
            numberOfNodes = currentActiveNode - sizes.INPUTS;

            % genes of the active node
            lastParameter = numberOfNodes * genesPerNode + sizes.INPUTS;

            % gene of the first parameter
            firstParameter = lastParameter - sizes.PARAMETERS + 1;

            allParameters = firstParameter:lastParameter;
            for k = 1:size(allParameters, 2)
                parameters(k) = genes(allParameters(k));
            end

            % call the function which index is given by currentFunctionGene
            values(currentActiveNode) = functionSet{currentFunctionGene}(firstConnection, secondConnection);
        end

        %   score = score + abs(values(activeNodes(end)) - programInputs.points.y(j));
        score = score + abs(values(activeNodes(end)) - programInputs.points.y(j));
    end
    
    if score < 0.1
        reportFitness(sizes, structure, genes, activeNodes, programInputs, score, run, generation);
    end
end
