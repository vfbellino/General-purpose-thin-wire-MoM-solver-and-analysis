function etaF = forwardEfficiency(U,phi,tht,alpha)
% FORWARDEFFICIENCY
% Frazione della potenza irradiata all'interno di un cono forward
% di semiapertura alpha rispetto alla direzione +x.
%
% INPUT:
%   U     : radiation intensity U(phi,r,theta)
%   phi   : vettore degli angoli azimutali [rad]
%   tht   : vettore delle colatitudini [rad]
%   alpha : semiapertura del cono forward [rad]
%
% OUTPUT:
%   etaF  : frazione di potenza nel cono forward, 0 <= etaF <= 1

phi = phi(:);
tht = tht(:);

% Pattern a r costante
U2 = squeeze(real(U(:,1,:)));

% Controllo dimensionale
if ~isequal(size(U2),[numel(phi),numel(tht)])
    error('forwardEfficiency:Dimensioni', ...
        'size(U2)=%s, Nphi=%d, Ntheta=%d', ...
        mat2str(size(U2)),numel(phi),numel(tht));
end

% Eventuali piccoli valori negativi numerici
U2(U2 < 0) = 0;

% Griglia angolare
[PHI,THT] = ndgrid(phi,tht);

% Direzione forward = +x
% phi0 = 0
% theta0 = pi/2
%
% cos(gamma) = r_hat dot x_hat
cosGamma = sin(THT).*cos(PHI);

cosGamma = max(-1,min(1,cosGamma));
gamma = acos(cosGamma);

% Regione forward
maskF = gamma <= alpha;

% Elemento di angolo solido:
% dOmega = sin(theta) dtheta dphi
weight = sin(THT);

% Integrazione discreta.
% Valida se phi e theta sono uniformemente campionati:
Ptot = sum(U2(:).*weight(:));

PF = sum(U2(maskF).*weight(maskF));

if Ptot <= 0 || ~isfinite(Ptot)
    error('Potenza angolare totale non valida.');
end

etaF = PF/Ptot;

% Controllo finale
if ~isscalar(etaF) || ~isreal(etaF) || ~isfinite(etaF)
    error('etaF non valido.');
end

end