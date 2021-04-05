# Cartesian Genetic Programming toolbox for Matlab

This is an implementation of a cartesian genetic programming toolbox for Matlab.

# Get Started

Just include the startup file that is on the root, and you are good to go.

You can follow along with the example of a symbolic regression provided [here](https://github.com/tiagoinacio/cgp4matlab/tree/master/examples/symbolic-regression).

## Configuration

The first step is to instantiate the `cgp` toolbox and provide the configuration. Example:
```
cgp = cgptoolbox.CGP(struct( ...
    'rows', 1, ...
    'columns', 10, ...
    'levels_back', 10, ...
    'output_type', 'random', ...
    'runs', 100, ...
    'outputs', 1, ...
    'generations', 8000, ...
    'offspring', 10, ...
    'mutation', 0.02, ...
    'fitness_solution', 0.01, ...
    'fitness_operator', '<=' ...
));
```

## Inputs

You should then provide the `inputs` to the program as a struct, naming the input and providing the value. In this case, we are passing a `points` input which is itself a struct:

```
a = zeros(1, 50);
b = zeros(1, 50);
index = 1;
for x = -1:2/49:1
    a(index) = x^6 - 2*(x^4) + x^2;
    b(index) = x;
    index = index + 1;
end

cgp.addInputs( ...
    struct( ...
        'points', struct('x', b, 'y', a) ...
    ) ...
);
```

## Parameters

You can optionally provide parameters to the genotype. The `initialize` function is executed in order to generate the value for that parameter. the `mutate` function is called every time there is a mutation on that gene. The `mutate` function receives the previous value as argument, so you can easily mutate the gene based on his previous value:

```
% you can add parameters to the genotype
cgp.addParameters( ...
   struct(                                ...
       'name', 'interval',                ...
       'initialize', @()rand(),           ...
       'mutate', @(x)x + rand()           ...
   ), ...
   struct(                                ...
       'name', 'interval',                ...
       'initialize', @()rand(),           ...
       'mutate', @(x)x + rand()           ...
   ) ...
);
```

## Callbacks

If you want to know what the hell is going on behind the scenes, you can use callbacks. There are a number of callbacks available for you to set up. They are defined as a struct, with function handles (pointers to functions). If you have any doubts, check the Matlab documentation on [handles](https://www.mathworks.com/help/matlab/matlab_prog/creating-a-function-handle.html)

```
cgp.addCallbacks(struct(
      'CONFIGURATION', @my-configuration-callback-fn,
      'RUN', @my-run-callback-fn,
      'GENERATION', @my-generation-callback-fn,
      'GENERATION_ENDED', @(args)fprintf('generation: %d fitness: %.6f\n', args.generation, args.fitness), ...
      'GENOTYPE', @my-genotype-callback-fn,
      'GENOTYPE_MUTATED', @my-genotype-mutated-callback-fn
      'RUN_ENDED', @reportFitness ...
      'FITTEST_SOLUTION', @(args)fprintf('generation %d - %.12f\n',args.generation, args.fitness), ...
      ))
```

## Function Set

To define the function set, create a directory, and place all the function-set functions inside that directory. Then, provide the path to that directory to the cgp toolbox:

```
cgp.addFunctionsFromPath('function-set/');
```

NOTE: Please remember to add the function-set to your Matlab startup script, so the functions are loaded in memory. Check the [startup.m](https://github.com/tiagoinacio/cgp4matlab/blob/master/startup.m)

## Fitness Function

The fitness function is also set as an [handle](https://www.mathworks.com/help/matlab/matlab_prog/creating-a-function-handle.html). The function receives the following arguments:

```
struct( ...
    'config', vararg.config, ...
    'genes', vararg.genes, ...
    'activeNodes', vararg.activeNodes, ...
    'programInputs', vararg.programInputs, ...
    'functionSet', {vararg.functionSet}, ...
    'run', vararg.run, ...
    'generation', vararg.generation ...
)
```

With those arguments, you can calculate the new fitness, using your fitness function. See the [symbolic-regression](https://github.com/tiagoinacio/cgp4matlab/blob/master/examples/symbolic-regression/fitness.m) example for more details.

Example:

```
function fitness = myFitnessFunction(vararg)
  % calculate your new fitness based on the `vararg` genes that you received
  % return the new fitness value
  fitness = 2;
end

cgp.addFitnessFunction(@myFitnessFunction);
```

# Run

The last step is to tell the toolbox to run the program:

```
  cgp.run();
```

# Notes

This toolbox was created for the following thesis and research papers:

* [Evolution of classifiers for pitch estimation of piano music using cartesian genetic programming](https://iconline.ipleiria.pt/bitstream/10400.8/2341/1/Tiago%20Jo%C3%A3o%20Leite%20In%C3%A1cio-Mestrado%20em%20Eng.Inform%C3%A1tica-Computa%C3%A7%C3%A3o%20M%C3%B3vel.pdf)

* [Cartesian genetic programming applied to pitch estimation of piano notes](https://ieeexplore.ieee.org/document/7850046/)

* [CGP4Matlab - A Cartesian Genetic Programming MATLAB Toolbox for Audio and Image Processing](https://link.springer.com/chapter/10.1007/978-3-319-77538-8_31)
* [CGP4Matlab - A Cartesian Genetic Programming MATLAB Toolbox for Audio and Image Processing](https://link.springer.com/chapter/10.1007/978-3-319-77538-8_31)
* [CGP4Matlab - A Cartesian Genetic Programming MATLAB Toolbox for Audio and Image Processing](https://link.springer.com/chapter/10.1007/978-3-319-77538-8_31)
