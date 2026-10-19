% This function computes the power losses due to the finite conductivity of
% the material of the dipole (sigma).
% In input the following is needed:

% 1) (a) radius of the wire.
% 2) (zmid) mid points of the segments dividing the wire.
% 3) (Zs) the skin-effect impedance.
% 4) (I) the current on the wire.


function P_ohm = POWOHM(wire,sol,geom) 

Nw = numel(wire);

P_ohm = 0;

for i = 1:Nw
    I    = sol.Iwire{i};
    AI   = abs(I);
    Zs   = sol.Losswire{i};
    RZs  = real(Zs);

    a    = geom.wire(i).radius;
    sMid = geom.wire(i).sMid;
    F    = 0.5*AI.^2.*RZs;

    P_ohm = P_ohm + int1D(sMid,F);
end