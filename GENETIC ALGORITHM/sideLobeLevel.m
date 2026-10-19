function SLL = sideLobeLevel(U,phi,tht,mainWidth)

phi = phi(:);
tht = tht(:);

% Pattern a r costante
U2 = squeeze(real(U(:,1,:)));

% Controllo dimensionale
if ~isequal(size(U2),[numel(phi),numel(tht)])
    error('sideLobeLevel:Dimensioni', ...
        'size(U2)=%s, Nphi=%d, Ntheta=%d', ...
        mat2str(size(U2)),numel(phi),numel(tht));
end

% Piccoli valori negativi numerici
U2(U2 < 0) = 0;

% Massimo globale
[U0,idx] = max(U2(:));

if ~isfinite(U0) || U0 <= 0
    error('U0 non valido: %g',U0);
end

[j0,k0] = ind2sub(size(U2),idx);

phi0   = phi(j0);
theta0 = tht(k0);

% Griglia angolare
[PHI,THT] = ndgrid(phi,tht);

% Distanza angolare dal massimo
cosGamma = cos(THT).*cos(theta0) + ...
    sin(THT).*sin(theta0).*cos(PHI-phi0);

cosGamma = max(-1,min(1,cosGamma));
gamma = acos(cosGamma);

% Esclusione main lobe
mask = gamma > mainWidth;

if ~any(mask(:))
    error('La maschera non contiene punti fuori dal main lobe.');
end

% Massimo esterno
USL = max(U2(mask));

if ~isfinite(USL) || USL < 0
    error('USL non valido: %g',USL);
end

if USL == 0
    SLL = -Inf;
else
    SLL = 10*log10(USL/U0);
end

% Controllo fondamentale
if ~isscalar(SLL) || ~isreal(SLL) || isnan(SLL)
    error('SLL non valido: size=%s',mat2str(size(SLL)));
end

end