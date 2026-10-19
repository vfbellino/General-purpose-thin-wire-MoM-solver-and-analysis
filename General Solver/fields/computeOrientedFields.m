function [F_oriented,align] = computeOrientedFields(sol,wire,geom,medium,grid)  

Nw = numel(wire);

[F_align,align] = computeAlignFields(sol,wire,geom,medium,grid);

for i = 1:Nw
    Hr  = F_align.wire(i).Hr;
    Hph = F_align.wire(i).Hph;
    Hth = F_align.wire(i).Hth;
    Er  = F_align.wire(i).Er;
    Eph = F_align.wire(i).Eph;
    Eth = F_align.wire(i).Eth;

    rgrid_align  = align.wire(i).rgrid_align;
    phgrid_align = align.wire(i).phgrid_align;
    thgrid_align = align.wire(i).thgrid_align;

    [~,~,~,Hx,Hy,Hz] = FS2C(rgrid_align,phgrid_align,thgrid_align,Hr,Hph,Hth);
    [~,~,~,Ex,Ey,Ez] = FS2C(rgrid_align,phgrid_align,thgrid_align,Er,Eph,Eth);

    Ri = align.wire(i).rot_matrix;

    HX = Hx(:);
    HY = Hy(:);
    HZ = Hz(:);
    
    EX = Ex(:);
    EY = Ey(:);
    EZ = Ez(:);

    for j = 1:length(HX)
        vh = [HX(j);HY(j);HZ(j)];
        ve = [EX(j);EY(j);EZ(j)];

        uh = Ri*vh;
        ue = Ri*ve;

        HXoriented(j) = uh(1);
        HYoriented(j) = uh(2);
        HZoriented(j) = uh(3);

        EXoriented(j) = ue(1);
        EYoriented(j) = ue(2);
        EZoriented(j) = ue(3);
    end

    HXoriented = HXoriented(:);
    HYoriented = HYoriented(:);
    HZoriented = HZoriented(:);

    EXoriented = EXoriented(:);
    EYoriented = EYoriented(:);
    EZoriented = EZoriented(:);

    F_oriented.wire(i).Hxoriented = reshape(HXoriented,size(Hr));
    F_oriented.wire(i).Hyoriented = reshape(HYoriented,size(Hr));
    F_oriented.wire(i).Hzoriented = reshape(HZoriented,size(Hr));
    F_oriented.wire(i).Exoriented = reshape(EXoriented,size(Hr));
    F_oriented.wire(i).Eyoriented = reshape(EYoriented,size(Hr));
    F_oriented.wire(i).Ezoriented = reshape(EZoriented,size(Hr));
end


    