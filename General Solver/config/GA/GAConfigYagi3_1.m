function wire = GAConfigYagi3(medium)

% Rin = 49.9797, Xin = -5.0731, G0 = 6.7129, FBR = 17.5603

%% ------------------------------------------------------------
%  WIRE 1 - Driven element
%  ------------------------------------------------------------

wire(1).center   = [-0.2282 0 0];              % [x y z] [m]
wire(1).axis     = [0 0 1];              % orientation
wire(1).length   = 0.4480*medium.lambda;   % length [m]
wire(1).radius   = 1e-3*medium.lambda;   % radius [m]
wire(1).Nseg     = 31;

wire(1).sigma    = 5.8e7;                % copper [S/m]

wire(1).feedType = "delta";
wire(1).Vfeed    = 0;                  % [V]


%% ------------------------------------------------------------
%  WIRE 2 - Passive element
%  ------------------------------------------------------------

wire(2).center   = [0 0 0];
wire(2).axis     = [0 0 1];

wire(2).length   = 0.4784*medium.lambda;
wire(2).radius   = 1e-4*medium.lambda;
wire(2).Nseg     = 131;

wire(2).sigma    = 5.8e7;

wire(2).feedType = "delta";
wire(2).Vfeed    = 1;


%% ------------------------------------------------------------
%  WIRE 3 - Passive element
%  ------------------------------------------------------------

wire(3).center   = [0.2265*medium.lambda 0 0];
wire(3).axis     = [0 0 1];

wire(3).length   = 0.3931*medium.lambda;
wire(3).radius   = 1e-3*medium.lambda;
wire(3).Nseg     = 31;

wire(3).sigma    = 5.8e7;

wire(3).feedType = "delta";
wire(3).Vfeed    = 0;


