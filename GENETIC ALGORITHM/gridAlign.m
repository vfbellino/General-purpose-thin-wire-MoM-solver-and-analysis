function align = gridAlign(wire,geom,grid)

Nw = numel(wire);
rgrid  = grid.rmesh;
phgrid = grid.phmesh;
thgrid = grid.thmesh;

c = geom.centroid;

xgrid = rgrid.*cos(phgrid).*sin(thgrid);
ygrid = rgrid.*sin(phgrid).*sin(thgrid);
zgrid = rgrid.*cos(thgrid);

[m,n,l] = size(rgrid);

cx = c(1)*ones(m,n,l);
cy = c(2)*ones(m,n,l);
cz = c(3)*ones(m,n,l);

xcenter = xgrid - cx;
ycenter = ygrid - cy;
zcenter = zgrid - cz;

align.rgrid_center   = sqrt(xcenter.^2 + ycenter.^2 + zcenter.^2);
align.phgrid_center  = atan2(ycenter,xcenter);
align.thgrid_center  = acos(zcenter./align.rgrid_center);

for i = 1:Nw
    zd = geom.wire(i).axis; zdperp = null(zd);
    xd = zdperp(:,1)';
    yd = zdperp(:,2)';
    e = eye(3);
    x = e(1,:);
    y = e(2,:);
    z = e(3,:);

    Ri(1,1) = dot(x,xd);
    Ri(1,2) = dot(x,yd);
    Ri(1,3) = dot(x,zd);
    Ri(2,1) = dot(y,xd);
    Ri(2,2) = dot(y,yd);
    Ri(2,3) = dot(y,zd);
    Ri(3,1) = dot(z,xd);
    Ri(3,2) = dot(z,yd);
    Ri(3,3) = dot(z,zd);

    align.wire(i).rot_matrix = Ri;

    ci = geom.wire(i).center;

    cix = ci(1)*ones(m,n,l);
    ciy = ci(2)*ones(m,n,l);
    ciz = ci(3)*ones(m,n,l);

    xrelgrid = xgrid - cix;
    yrelgrid = ygrid - ciy;
    zrelgrid = zgrid - ciz;

    Xrelgrid = xrelgrid(:);
    Yrelgrid = yrelgrid(:);
    Zrelgrid = zrelgrid(:);
    
    for j = 1:length(Xrelgrid)
        v = [Xrelgrid(j);Yrelgrid(j);Zrelgrid(j)];
        u = Ri.'*v;
        rotXrelgrid(j) = u(1);
        rotYrelgrid(j) = u(2);
        rotZrelgrid(j) = u(3);
    end
    
    rotXrelgrid = rotXrelgrid(:);
    rotYrelgrid = rotYrelgrid(:);
    rotZrelgrid = rotZrelgrid(:);

    xgridnew = reshape(rotXrelgrid,size(xgrid));
    ygridnew = reshape(rotYrelgrid,size(xgrid));
    zgridnew = reshape(rotZrelgrid,size(xgrid));

    align.wire(i).rgrid_align   = sqrt(xgridnew.^2 + ygridnew.^2 + zgridnew.^2);
    align.wire(i).phgrid_align  = atan2(ygridnew,xgridnew);
    align.wire(i).thgrid_align  = acos(zgridnew./align.wire(i).rgrid_align);
end