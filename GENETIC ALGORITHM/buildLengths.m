function population = buildLengths(initGA,chromosome)

Npop = initGA.Npop;
bits = initGA.Nbits;
xmin = initGA.lowbound;
xmax = initGA.upbound;

N = length(xmin);

for i = 1:Npop
    population.element(i).bits = chromosome(i,:);
    CH = reshape(chromosome(i,:),bits,N).';
    weights = 2.^(bits-1:-1:0);
    q = CH * weights.';
    x = xmin + (q/(2^bits-1)).*(xmax-xmin);
    population.element(i).lengths = x;
end

population.Npop = Npop;

