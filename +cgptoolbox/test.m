listOfSpecs = dir([pwd, '/tests/']);
listOfSpecs = listOfSpecs(~ismember({listOfSpecs.name},{'.','..'}));

for i = 1:length(listOfSpecs)
   runtests([listOfSpecs(i).name, 'Spec'])
end