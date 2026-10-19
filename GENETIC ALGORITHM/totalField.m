function [E,H] = totalField(sol,wire,geom,medium,grid)

Nw = numel(wire);

[F_oriented,align] = computeOrientedFields(sol,wire,geom,medium,grid);

rgrid_center  = align.rgrid_center;
phgrid_center = align.phgrid_center;
thgrid_center = align.thgrid_center;

Hxtot = 0;
Hytot = 0;
Hztot = 0;
Extot = 0;
Eytot = 0;
Eztot = 0;

for i = 1:Nw
    Hxtot = Hxtot + F_oriented.wire(i).Hxoriented;
    Hytot = Hytot + F_oriented.wire(i).Hyoriented;
    Hztot = Hztot + F_oriented.wire(i).Hzoriented;

    Extot = Extot + F_oriented.wire(i).Exoriented;
    Eytot = Eytot + F_oriented.wire(i).Eyoriented;
    Eztot = Eztot + F_oriented.wire(i).Ezoriented;
end

xgrid = rgrid_center.*cos(phgrid_center).*sin(thgrid_center);
ygrid = rgrid_center.*sin(phgrid_center).*sin(thgrid_center);
zgrid = rgrid_center.*cos(thgrid_center);

[~,~,~,Hr,Hph,Hth] = FC2S(xgrid,ygrid,zgrid,Hxtot,Hytot,Hztot);
[~,~,~,Er,Eph,Eth] = FC2S(xgrid,ygrid,zgrid,Extot,Eytot,Eztot);


E = struct('rad',Er,'azim',Eph,'co_lat',Eth);
H = struct('rad',Hr,'azim',Hph,'co_lat',Hth);