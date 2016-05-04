function value = fitness(SIZE, STRUCTURE, genes, active, inputs, functions, run, generation)

    value = 0;
    nodesResult_ = zeros(1, SIZE.NODES);

    for j = 1:50
        nodesResult_(1) = inputs.first.x0(j);
        nodesResult_(2) = inputs.second;

        for i = SIZE.INPUTS + 1:size(active, 2)
            % start at number of inputs * number of nodes with inputs; 
            % plus the number of genes to get to the first
            % parameter;
            paramGenes = (active(i) - SIZE.INPUTS) * (3 + SIZE.PARAMETERS) + SIZE.INPUTS - SIZE.PARAMETERS + 1:(active(i) - SIZE.INPUTS) * (3 + SIZE.PARAMETERS) + SIZE.INPUTS;
            for k = 1:size(paramGenes, 2)
              params(k) = genes(paramGenes(k));
            end
    
            geneFn = genes(STRUCTURE.FUNCTIONS(active(i)));
            firstInput = nodesResult_(genes(STRUCTURE.CONNECTIONS{1}(active(i))));
            secondInput = nodesResult_(genes(STRUCTURE.CONNECTIONS{2}(active(i))));
            
            result = functions{geneFn}(firstInput, secondInput, params);
            
            nodesResult_(active(i)) = result;
        end

        value = value + abs(nodesResult_(active(end)) - inputs.first.y0(j));
    end

    if value <= -100
        value = 0;
    else
        value = 1 - (value / 100);
    end
    
    if value > 0.5
        reportFitness(SIZE, STRUCTURE, genes, active, inputs, value, run, generation);
    end
end
