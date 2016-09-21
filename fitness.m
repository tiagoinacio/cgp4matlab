function score = fitness(args) % sizes, structure, genes, activeNodes, programInputs, functionSet, run, generation)
    score = 0.0;
    values = zeros(1, args.config.sizes.nodes);

    % for each data point or test case
    for j = 1:50
        values(1) = args.programInputs.points.x(j);
        values(2) = args.programInputs.scalar;

        % iterate through active nodes
        for i = args.config.sizes.inputs + 1:size(args.activeNodes, 2)
            % get current active node that we want to decode
            currentActiveNode = args.activeNodes(i);

            % get the gene that points to the function-gene of the active node
            functionGeneOfActiveNode = args.config.structure.functionGenes(currentActiveNode);

            % get the function gene of the active node
            currentFunctionGene = args.genes(functionGeneOfActiveNode);

            % get the genes index
            geneFirstConnection = args.config.structure.connectionGenes{1}(currentActiveNode);
            geneSecondConnection = args.config.structure.connectionGenes{2}(currentActiveNode);

            % get the nodes index
            nodeFirstConnection = args.genes(geneFirstConnection);
            nodeSecondConnection = args.genes(geneSecondConnection);

            % get the values of the connections
            firstConnection = values(nodeFirstConnection);
            secondConnection = values(nodeSecondConnection);

            % find how many genes per node
            genesPerNode = 3 + args.config.sizes.parameters;

            % find how many nodes are before the current node in the genotype
            numberOfNodes = currentActiveNode - args.config.sizes.inputs;

            % genes of the active node
            lastParameter = numberOfNodes * genesPerNode + args.config.sizes.inputs;

            % gene of the first parameter
            firstParameter = lastParameter - args.config.sizes.parameters + 1;

            allParameters = firstParameter:lastParameter;
            for k = 1:size(allParameters, 2)
                parameters(k) = args.genes(allParameters(k));
            end

            % call the function which index is given by currentFunctionGene
            values(currentActiveNode) = args.functionSet{currentFunctionGene}(firstConnection, secondConnection);
        end
        
        % compute the sum of squared error
        score = score + abs(values(args.activeNodes(end)) - args.programInputs.points.y(j));
    end

    if score < 0.1
        reportFitness(args.config.sizes, args.config.structure, args.genes, args.activeNodes, args.programInputs, score, args.run, args.generation);
    end
end
% function score = fitness(sizes, structure, genes, activeNodes, programInputs, functionSet, run, generation)
% 
%     score = 0.0;
%     values = zeros(1, sizes.nodes);
% 
%     % for each data point or test case
%     for j = 1:50
%         values(1) = programInputs.points.x(j);
%         values(2) = programInputs.scalar;
% 
%         % iterate through active nodes
%         for i = sizes.inputs + 1:size(activeNodes, 2)
%             % get current active node that we want to decode
%             currentActiveNode = activeNodes(i);
% 
%             % get the gene that points to the function-gene of the active node
%             functionGeneOfActiveNode = structure.functions(currentActiveNode);
% 
%             % get the function gene of the active node
%             currentFunctionGene = genes(functionGeneOfActiveNode);
% 
%             % get the genes index
%             geneFirstConnection = structure.connections{1}(currentActiveNode);
%             geneSecondConnection = structure.connections{2}(currentActiveNode);
% 
%             % get the nodes index
%             nodeFirstConnection = genes(geneFirstConnection);
%             nodeSecondConnection = genes(geneSecondConnection);
% 
%             % get the values of the connections
%             firstConnection = values(nodeFirstConnection);
%             secondConnection = values(nodeSecondConnection);
% 
%             % find how many genes per node
%             genesPerNode = 3 + sizes.parameters;
% 
%             % find how many nodes are before the current node in the genotype
%             numberOfNodes = currentActiveNode - sizes.inputs;
% 
%             % genes of the active node
%             lastParameter = numberOfNodes * genesPerNode + sizes.inputs;
% 
%             % gene of the first parameter
%             firstParameter = lastParameter - sizes.parameters + 1;
% 
%             allParameters = firstParameter:lastParameter;
%             for k = 1:size(allParameters, 2)
%                 parameters(k) = genes(allParameters(k));
%             end
% 
%             % call the function which index is given by currentFunctionGene
%             values(currentActiveNode) = functionSet{currentFunctionGene}(firstConnection, secondConnection);
%         end
% 
%         %   score = score + abs(values(activeNodes(end)) - programInputs.points.y(j));
%         score = score + abs(values(activeNodes(end)) - programInputs.points.y(j));
%     end
% 
%     if score < 0.1
%         reportFitness(sizes, structure, genes, activeNodes, programInputs, score, run, generation);
%     end
% end
