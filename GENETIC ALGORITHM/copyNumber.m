function [copies,rem] = copyNumber(medium,initGA,population)

Npop = population.Npop;
antenna = configYagi(medium,population);

parfor i=1:Npop
    wire_i   = antenna(i).wire;
    Obj(i) = objFun1(wire_i,initGA);
end

mObj   = mean(Obj);
stdObj = std(Obj,1);

f = max(0,Obj - (mObj - 2*stdObj));

if sum(f) == 0
    p = ones(size(f))/Npop;
else
    p = f./sum(f);
end

e = Npop*p;
copies = floor(e);
rem = e-copies;