function newChromosome = mating(initGA,matPool) 

pc   = initGA.probCross;
pm   = initGA.probMut;
Npop = initGA.Npop;

for i=1:Npop/2
    rc = rand;
    parent1 = matPool.element(i).bits;
    parent2 = matPool.element(Npop-i+1).bits;
    n = length(parent1);
    if rc<= pc
        child1 = [parent1(1:n-4),parent2(n-3:n)];
        child2 = [parent2(1:n-4),parent1(n-3:n)];
        newChromosome(i,:) = child1;
        newChromosome(Npop-i+1,:) = child2;
    else
        child1 = parent1;
        child2 = parent2;
        newChromosome(i,:) = child1;
        newChromosome(Npop-i+1,:) = child2;
    end
end

mutationMask = rand(size(newChromosome)) < pm;

newChromosome(mutationMask) = 1 - newChromosome(mutationMask);

        