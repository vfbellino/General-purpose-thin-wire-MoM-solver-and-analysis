function wire = GAConfigYagi3(medium,N)

% lambda = 0.7

%% ------------------------------------------------------------
%  WIRE 1 - Driven element
%  ------------------------------------------------------------

wire(1).center   = [-0.1499 0 0];              % [x y z] [m]
wire(1).axis     = [0 0 1];              % orientation
wire(1).length   = 0.3431;   % length [m]
wire(1).radius   = 3e-3*medium.lambda;   % radius [m]
wire(1).Nseg     = N;

wire(1).sigma    = 3.5e7;                % copper [S/m]

wire(1).feedType = "delta";
wire(1).Vfeed    = 0;                  % [V]


%% ------------------------------------------------------------
%  WIRE 2 - Passive element
%  ------------------------------------------------------------

wire(2).center   = [0 0 0];
wire(2).axis     = [0 0 1];

wire(2).length   = 0.2189;
wire(2).radius   = 3e-3*medium.lambda;
wire(2).Nseg     = N;

wire(2).sigma    = 3.5e7;

wire(2).feedType = "delta";
wire(2).Vfeed    = 1;


%% ------------------------------------------------------------
%  WIRE 3 - Passive element
%  ------------------------------------------------------------

wire(3).center   = [0.1532 0 0];
wire(3).axis     = [0 0 1];

wire(3).length   = 0.2821;
wire(3).radius   = 3e-3*medium.lambda;
wire(3).Nseg     = N;

wire(3).sigma    = 3.5e7;

wire(3).feedType = "delta";
wire(3).Vfeed    = 0;


