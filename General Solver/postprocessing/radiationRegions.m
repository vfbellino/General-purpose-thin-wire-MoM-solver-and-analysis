function [etaF,etaL,etaB] = radiationRegions(U,phi,tht)

phi = phi(:);
tht = tht(:);

% U(phi,r,theta)
U2 = squeeze(real(U(:,1,:)));
U2(U2 < 0) = 0;

if ~isequal(size(U2),[numel(phi),numel(tht)])
    error('Dimensioni U incompatibili con phi e theta');
end

[PHI,THT] = ndgrid(phi,tht);

% Distanza angolare dalla direzione forward +x
cosGamma = sin(THT).*cos(PHI);
cosGamma = max(-1,min(1,cosGamma));
gamma = acos(cosGamma);

% dOmega = sin(theta)dtheta dphi
W = sin(THT);

% Regioni
maskF = gamma < pi/3;                    % 0° - 60°
maskL = gamma >= pi/3 & gamma < 2*pi/3; % 60° - 120°
maskB = gamma >= 2*pi/3;                 % 120° - 180°

Ptot = sum(U2(:).*W(:));

PF = sum(U2(maskF).*W(maskF));
PL = sum(U2(maskL).*W(maskL));
PB = sum(U2(maskB).*W(maskB));

etaF = PF/Ptot;
etaL = PL/Ptot;
etaB = PB/Ptot;

end