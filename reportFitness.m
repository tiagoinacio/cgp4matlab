function reportFitness(args)

    formulas = cell(1, args.config.sizes.nodes);
    formulas{1} = 'x';
    %formulas{2} = [num2str(args.programInputs.scalar)];
    output = args.activeNodes(end);


    for i = 2:size(args.activeNodes, 2)
        current_node = args.activeNodes(i);
        first_connection_array = args.config.structure.connectionGenes{1};
        second_connection_array = args.config.structure.connectionGenes{2};
        first_connection_index = first_connection_array(current_node);
        second_connection_index = second_connection_array(current_node);
        first_connection_gene = args.genes(first_connection_index);
        second_connection_gene = args.genes(second_connection_index);
        function_index = args.config.structure.functionGenes(current_node);

        formula = ['(', num2str(formulas{first_connection_gene})];
        switch args.genes(function_index);
            case 1
                %if logical(eq(formulas{second_connection_gene}, 0)) || logical(eq(formulas{second_connection_gene},  0))
                %   formulas{current_node + 2} = '0';
                %   continue;
                %else
                   formula = [formula, ' / '];
                %end
            case 2
                formula = [formula, ' - '];
            case 3
                formula = [formula, ' + '];
            case 4
                formula = [formula, ' * '];
        end
        formula = [formula, num2str(formulas{second_connection_gene}), ')'];

        formulas{current_node} = formula;
    end

    try
        x = sym('x');
        str = eval(formulas{output})

        generationFigure = figure;
        set(generationFigure, 'name', ['Run (', num2str(args.run), ')'],'numbertitle','off');
        scatter(args.programInputs.points.x, args.programInputs.points.y);

        hold on;
        try
            %lastGeneration = ezplot(str, [config.minX, config.maxX, config.minY, config.maxY]);
            lastGeneration = ezplot(str, [-1, 1, 0, 0.2]);
            legend([lastGeneration], ['Last Generation']);
        catch
        end
    catch
    end
end
