function [Z,V,loss,feedvec] = assembleMoM(wire,geom,medium)

Z = zeros(geom.Ntotal);
V = zeros(geom.Ntotal,1);
Nw = numel(wire);
feedvec = zeros(1,Nw);

for i = 1:Nw
    ii         = geom.wire(i).idx;
    dl         = geom.wire(i).dl;

    feed       = (ii(end)+ii(1))/2;
    feedvec(i) = feed;

    V(feed)    = wire(i).Vfeed/dl;
    
    for j = 1:Nw
        jj = geom.wire(j).idx;
        if i == j
            [Zii,Zloss] = selfImpedanceBlock(i,j,wire,geom,medium);
                Z(ii,ii) = Zii;
                loss(j) = Zloss;
        else
            Zij = mutualImpedanceBlock(i,j,geom,medium);
                Z(ii,jj) = Zij;
        end
    end
end

