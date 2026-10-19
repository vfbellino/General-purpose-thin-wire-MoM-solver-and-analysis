%% ------------------------------------------------------------
%  MEDIUM
%  ------------------------------------------------------------

function medium = medium1()

medium.eps0 = 8.8541878128e-12;
medium.mu0  = 4*pi*1e-7;

medium.epsr = 1;
medium.mur  = 1;

medium.eps = medium.eps0 * medium.epsr;
medium.mu  = medium.mu0  * medium.mur;

medium.lambda = 0.6;                     % [m]
medium.wavenumb      = 2*pi / medium.lambda;  % [rad/m]

medium.omega  = medium.wavenumb / ...
    sqrt(medium.mu*medium.eps);

medium.freq      = medium.omega/(2*pi);   % [Hz]

medium.eta    = sqrt(medium.mu/medium.eps);

