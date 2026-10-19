function Zij = mutualImpedanceBlock(i,j,geom,medium)

eps   = medium.eps;
omega = medium.omega;

Nsegi  = geom.wire(i).Nseg;
Nsegj  = geom.wire(j).Nseg;
dlj    = geom.wire(j).dl;

for h = 1:Nsegi
    for k = 1:Nsegj
            K        = impedanceKernel(i,j,h,k,geom,medium);
            Zij(h,k) = integral(@(s) arrayfun(K,s),-dlj/2,dlj/2);
    end
end

Zij = (1i/(omega*eps))*Zij;