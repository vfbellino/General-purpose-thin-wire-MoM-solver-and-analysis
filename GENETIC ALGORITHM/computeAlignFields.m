function [F_align,align] = computeAlignFields(sol,wire,geom,medium,grid)

Nw = numel(wire);

Kf   = fieldKernels(medium);
KHph = Kf.Hph;
KEr  = Kf.Er;
KEth = Kf.Eth;

align = gridAlign(wire,geom,grid);

for i = 1:Nw
    dl   = geom.wire(i).dl;
    sMid = geom.wire(i).sMid;
    Q    = length(sMid);
    w    = dl*ones(Q,1);

    rgrid_align   = align.wire(i).rgrid_align;
    phgrid_align  = align.wire(i).phgrid_align;
    thgrid_align  = align.wire(i).thgrid_align;

    I = sol.Iwire{i};

    SS   = reshape(sMid,1,1,1,Q);
    II   = reshape(I,1,1,1,Q);
    WW   = reshape(w,1,1,1,Q);

    KH = KHph(rgrid_align,phgrid_align,thgrid_align,SS);
    Hph = sum(WW .* II .* KH,4);

    KER = KEr(rgrid_align,phgrid_align,thgrid_align,SS);
    Er = sum(WW .* II .* KER,4);

    KET = KEth(rgrid_align,phgrid_align,thgrid_align,SS);
    Eth = sum(WW .* II .* KET,4);

    [m,n,l] = size(Hph);
    Hr = zeros(m,n,l);
    Hth = zeros(m,n,l);
    Eph = zeros(m,n,l);

    F_align.wire(i).Hr  = Hr;
    F_align.wire(i).Hph = Hph;
    F_align.wire(i).Hth = Hth;
    F_align.wire(i).Er  = Er;
    F_align.wire(i).Eph = Eph;
    F_align.wire(i).Eth = Eth;
end

