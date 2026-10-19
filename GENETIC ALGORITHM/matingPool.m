function matPool = matingPool(copies,rem,population)

n = 0;
N = length(copies);

for i = 1:length(copies)
    if copies(i) ~= 0
        for j = 1:copies(i)
            matPool.element(n+j).bits = population.element(i).bits;
        end
        n = n + copies(i);
    else
        n = n + copies(i);
    end
end

pRem = rem./sum(rem);
cumP = cumsum(pRem);

for k = 1:N-n
    r = rand;
    idx = find(r <= cumP, 1, 'first');
    matPool.element(n+k).bits = population.element(idx).bits;
end

Npop = numel(matPool.element);
idx = randperm(Npop);
matPool.element = matPool.element(idx);