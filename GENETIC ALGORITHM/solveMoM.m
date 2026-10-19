function sol = solveMoM(Z,V,loss,feedvec,wire,geom)

Nw = numel(wire);

sol.Iglobal = Z\V;
sol.condZ   = cond(Z);

offset = 0;

for i = 1:Nw
    idx             = geom.wire(i).idx;
    sol.Iwire{i}    = sol.Iglobal(idx);
    
    sol.feed{i}     = feedvec(i)-offset;
    offset          = offset+geom.wire(i).Nseg; 
    
    sol.Losswire{i} = loss(i);
    dl              = geom.wire(i).dl;
    sol.V{i}        = V(feedvec(i))*dl;
end

sol.residual = norm(Z*sol.Iglobal-V)/norm(V);