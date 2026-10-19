function [Zii,Zloss] = selfImpedanceBlock(i,j,wire,geom,medium)

eps   = medium.eps;
mu    = medium.mu;
omega = medium.omega;

sigma = wire(j).sigma; 

a     = geom.wire(j).radius;
Nseg  = geom.wire(j).Nseg;
dl    = geom.wire(j).dl;

for k = 1:Nseg
        K      = impedanceKernel(i,j,1,k,geom,medium);
        int(k) = integral(@(s) arrayfun(K,s),-dl/2,dl/2);
end

toep = int(:);
Zii = toeplitz(toep,toep.'); Zii = (1i/(omega*eps))*Zii;

Zs = (1+1i)*sqrt(omega*mu/(2*sigma));
Zloss = Zs/(2*pi*a);

Zii = Zii + Zloss*eye(Nseg);