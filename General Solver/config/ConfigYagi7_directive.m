function [wire] = ConfigYagi7_directive(medium)

lambda = medium.lambda;

a     = 1e-4*lambda;
sigma = 5.8e7;

%% Positions along x, normalized to lambda
x = [ ...
    0.000 ...   % reflector
    0.200 ...   % driven
    0.275 ...   % director 1
    0.455 ...   % director 2
    0.670 ...   % director 3
    0.920 ...   % director 4
    1.200 ...   % director 5
    ] * lambda;

%% Lengths
L = [ ...
    0.515 ...   % reflector
    0.485 ...   % driven
    0.445 ...   % director 1
    0.438 ...   % director 2
    0.432 ...   % director 3
    0.426 ...   % director 4
    0.420 ...   % director 5
    ] * lambda;

Nseg = 101;

for n = 1:7

    wire(n).center = [x(n), 0, 0];
    wire(n).axis   = [0, 0, 1];

    wire(n).length = L(n);
    wire(n).radius = a;

    wire(n).Nseg   = Nseg;
    wire(n).sigma  = sigma;

    wire(n).Vfeed  = 0;

end

%% Driven element
wire(2).Vfeed = 1;

end