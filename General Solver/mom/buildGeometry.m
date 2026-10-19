function geom = buildGeometry(wire)

C = vertcat(wire.center);
T = vertcat(wire.axis); T_norms = vecnorm(T, 2, 2); T = T(:,1:end)./T_norms;
N = vertcat(wire.Nseg);
L = vertcat(wire.length);
A = vertcat(wire.radius);
H = L./N;

Nw = numel(wire);
offset = 0;

for k = 1:Nw
    sMid = (-L(k)/2+H(k)/2):H(k):(L(k)/2-H(k)/2);
    for j = 1:length(sMid)
        rMid(j,:,k) = C(k,:) + sMid(j)*T(k,:);
    end
    geom.wire(k).center = C(k,:);
    geom.wire(k).axis   = T(k,:);
    geom.wire(k).length = L(k);
    geom.wire(k).radius = A(k);
    geom.wire(k).Nseg   = N(k);
    geom.wire(k).dl     = H(k);
    geom.wire(k).sMid   = sMid;
    geom.wire(k).rMid   = rMid(:,:,k);
    
    tperp = null(T(k,:));
    radiusVec(k,:) = A(k)*tperp(:,1)';

    geom.wire(k).radiusVec   = radiusVec(k,:);

    geom.wire(k).idx = offset + (1:N(k));
    offset = offset + N(k);
end

geom.centroid = mean(C,1); 
geom.Ntotal = offset;


figure
hold on
grid on
box on

for i = 1:Nw

    r = geom.wire(i).rMid;

    plot3(r(1:N(i),1), ...
        r(1:N(i),2), ...
        r(1:N(i),3), ...
        '.-', ...
        'LineWidth',2, ...
        'MarkerSize',10);

end

xlabel('x [m]')
ylabel('y [m]')
zlabel('z [m]')

axis equal
view(45,25)