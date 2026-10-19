function K = impedanceKernel(i,j,p,q,geom,medium)

k = medium.wavenumb;

ti  = geom.wire(i).axis;
tj  = geom.wire(j).axis;
ri  = geom.wire(i).rMid;
rj  = geom.wire(j).rMid;


G = @(D) exp(-1i*k*D)/(4*pi*D);
A = @(D) k^2 - 1i*k/D - 1/D^2;
B = @(D) -k^2 + 3i*k/D + 3/D^2;

if i == j
    ai    = geom.wire(i).radiusVec;
    riipq = @(s) ai + (ri(p,:)-rj(q,:)-s*tj);
    diipq = @(s) norm(riipq(s));
    rhat  = @(s) riipq(s)./diipq(s);

    K = @(s) G(diipq(s)) * (A(diipq(s))*dot(ti,tj) ...
        + B(diipq(s))*dot(ti,rhat(s))*dot(tj,rhat(s)) );

else 
    rijpq = @(s) ri(p,:)-rj(q,:)-s*tj;
    dijpq = @(s) norm(rijpq(s));
    rhat  = @(s) rijpq(s)./dijpq(s);

    K = @(s) G(dijpq(s)) * (A(dijpq(s))*dot(ti,tj) ...
        + B(dijpq(s))*dot(ti,rhat(s))*dot(tj,rhat(s)) );
end
