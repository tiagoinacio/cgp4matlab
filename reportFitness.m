function reportFitness(SIZE, STRUCTURE, genes, active, inputs, fitness, run, generation)

    formulas = cell(1, SIZE.NODES);
    formulas{1} = 'x';
    formulas{2} = [num2str(inputs.scalar)];
    output = active(end);


    for i = 3:size(active, 2)
        current_node = active(i);
        first_connection_array = STRUCTURE.CONNECTIONS{1};
        second_connection_array = STRUCTURE.CONNECTIONS{2};
        first_connection_index = first_connection_array(current_node);
        second_connection_index = second_connection_array(current_node);
        first_connection_gene = genes(first_connection_index);
        second_connection_gene = genes(second_connection_index);
        function_index = STRUCTURE.FUNCTIONS(current_node);

        formula = ['(', num2str(formulas{first_connection_gene})];
        switch genes(function_index);
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
        set(generationFigure, 'name', ['Generation (', num2str(run), ')'],'numbertitle','off');
        scatter(inputs.points.x, inputs.points.y);

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