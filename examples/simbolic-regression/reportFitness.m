function reportFitness(SIZE, STRUCTURE, genes, active, inputs, fitness, run, generation)

    debugResults = cell(1, SIZE.NODES);
    debugResults{1} = 'x';
    debugResults{2} = [num2str(inputs.second)];

    for i = 1:size(active, 2)
        formula = ['(', num2str(debugResults{genes(STRUCTURE.CONNECTIONS{1}(active(i)))})];
        switch (genes(STRUCTURE.FUNCTIONS(active(i))));
            case 1
                formula = [formula, ' / '];
            case 2
                formula = [formula, ' - '];
            case 3
                formula = [formula, ' + '];
            case 4
                formula = [formula, ' * '];
        end
        formula = [formula, num2str(debugResults{genes(STRUCTURE.CONNECTIONS{2}(active(i)))}), ')'];

        debugResults{active(i)} = formula;
    end

    try
        x = sym('x');
        str = eval(debugResults{active(end)});
        if mod(generation, 500)
            generationFigure = figure;
            set(generationFigure, 'name', ['Generation (', num2str(run), ')'],'numbertitle','off');
            scatter(inputs.first.a.x, inputs.first.a.y);

            hold on;
            try
                %lastGeneration = ezplot(str, [config.minX, config.maxX, config.minY, config.maxY]);
                lastGeneration = ezplot(str, [-1, 1, 0, 0.2]);
                legend([lastGeneration], ['Last Generation']);
            catch
            end
        end
    catch
    end 
end