function wire = ConfigYagi7(medium)

% ---------------------------------------------------------
% 1 - REFLECTOR
% ---------------------------------------------------------
wire(1).center = [-0.25*medium.lambda, 0, 0];
wire(1).axis   = [0, 0, 1];
wire(1).length      = 0.525*medium.lambda;
wire(1).radius      = 1e-4*medium.lambda;
wire(1).Nseg   = 105;
wire(1).sigma  = 5.8e7;
wire(1).Vfeed  = 0;

% ---------------------------------------------------------
% 2 - DRIVEN
% ---------------------------------------------------------
wire(2).center = [0, 0, 0];
wire(2).axis   = [0, 0, 1];
wire(2).length      = 0.485*medium.lambda;
wire(2).radius      = 1e-4*medium.lambda;
wire(2).Nseg   = 101;
wire(2).sigma  = 5.8e7;
wire(2).Vfeed  = 1;

% ---------------------------------------------------------
% DIRECTORS
% ---------------------------------------------------------

xdir = [0.18 0.38 0.59 0.81 1.04]*medium.lambda;
Ldir = [0.455 0.445 0.440 0.435 0.430]*medium.lambda;

for i = 1:5

    n = i + 2;

    wire(n).center = [xdir(i), 0, 0];
    wire(n).axis   = [0, 0, 1];
    wire(n).length      = Ldir(i);
    wire(n).radius      = 1e-4*medium.lambda;

    % Odd number of segments
    wire(n).Nseg   = 101;

    wire(n).sigma  = 5.8e7;
    wire(n).Vfeed  = 0;

end