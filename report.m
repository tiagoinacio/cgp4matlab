classdef Report
    %REPORT Summary of this class goes here
    %   Detailed explanation goes here

    properties
        fileId_
    end

    methods

        function this = Report(config)
            this.fileId_ = fopen(this.getReportPathByFileName('results'), 'a+');
        end

        function reportMain_(this, config, run, generation, parent, error)
            % config.debug = true;
            % Fitness(config, parent.genes, inputs)
%             if strcmp(config.problem, 'even-parity')
%                 if (config.run == 1)
%                     fprintf(this.fileId_,'Run - Generation - Fitness\n');
%                 end
%                 fprintf(this.fileId_,'%d   - %d     - %6e\n', config.run, config.generation, parent.fitness);
%             else
                errorFigure = figure;
                set(errorFigure, 'name', 'Error','numbertitle','off');
                xlabel('square error');
                plot(abs(error))
                if this.fileId_ == -1
                    return;
                end
                if (run == 1)
                    fprintf(this.fileId_,'Run - Generation - Fitness\n');
                end
                fprintf(this.fileId_,'%d   - %d     - %6e\n', run, generation, parent.fitness_.get());
           % end
        end

        function reportGenerations(~, config, inputs, parent, fitness)
            if config.debug
                reportFitness(config, parent.genes, inputs, parent.fitness);
                reportMain(config, parent, fitness);
            end
        end

        function reportGeneration_(~, config, parent, generation)
            if config.debug
                fprintf(1, 'gen: %d min fitness %d\n', generation, parent.fitness_.get());
            end
        end

        function path = getReportPathByFileName(~, name)
            path = ['results/', name, '-', datestr(datetime('now', 'format', 'HH-mm-ss')), '.txt'];
        end

        function closeReports(this)
            %for i = 1:length(reports)
                fclose(this.fileId_);
            %end
        end

        function activeNodes = activeGenes_(~, config, genotype)

            nodesToIterate = zeros(1, config.numberOfOutputs);
            activeNodes = [];

            % add outputs
            for i = 1:config.numberOfOutputs
                nodesToIterate(i) = genotype(end - i + 1);
            end

            for i = 1:config.numberOfAllNodes
                % if there is no more nodesToIterate, break the loop
                if (size(nodesToIterate, 2) < i)
                    break;
                end

                % if is input, dont calculate connections, cause its a raw value
                % else, append the connection genes
                if (nodesToIterate(i) <= config.numberOfInputs)
                    continue;
                end

                activeNodes(end + 1) = nodesToIterate(i);

                nodesToIterate = [ ...
                    nodesToIterate, ...
                    genotype(config.arrayOfConnectionGenes{1}(nodesToIterate(i))), ...
                    genotype(config.arrayOfConnectionGenes{2}(nodesToIterate(i))) ...
                ];
            end
            activeNodes = unique(activeNodes);
        end

    end
end
