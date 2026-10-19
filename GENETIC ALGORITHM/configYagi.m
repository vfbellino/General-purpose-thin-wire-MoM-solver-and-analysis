function antenna = configYagi(medium,population)

X = [population.element.lengths].';
[M,N] = size(X);
Nw = (N+1)/2;

for i = 1:M
    s = -X(i,Nw+1);
    for j = 1:Nw-1
        antenna(i).wire(j).center   = [s 0 0];                % [x y z] [m]
        antenna(i).wire(j).axis     = [0 0 1];                % orientation
        antenna(i).wire(j).length   = X(i,j);                 % length [m]
        if j == 2
            antenna(i).wire(j).Nseg     = 23;
            antenna(i).wire(j).radius   = 0.003;     % radius [m]
        else
            antenna(i).wire(j).Nseg     = 23;
            antenna(i).wire(j).radius   = 0.003;     % radius [m]
        end
        antenna(i).wire(j).sigma    = 3.5e7;                  % copper [S/m]
        antenna(i).wire(j).feedType = "delta";
        if j == 2
            antenna(i).wire(j).Vfeed    = 1;                  % [V]
        else
            antenna(i).wire(j).Vfeed    = 0;                  % [V]
        end
        s = s + X(i,Nw+j);
    end
    antenna(i).wire(Nw).center   = [s 0 0];
    antenna(i).wire(Nw).axis     = [0 0 1];                
    antenna(i).wire(Nw).length   = X(i,Nw); 
    antenna(i).wire(Nw).radius   = 3e-3*medium.lambda;     % radius [m]
    if Nw == 2
        antenna(i).wire(Nw).Nseg     = 23;
        antenna(i).wire(j).radius   = 0.003;     % radius [m]
    else
        antenna(i).wire(Nw).Nseg     = 23;
        antenna(i).wire(j).radius   = 0.003;     % radius [m]
    end
    antenna(i).wire(Nw).sigma    = 3.5e7;                  % copper [S/m]
    antenna(i).wire(Nw).feedType = "delta";
    if Nw == 2
        antenna(i).wire(Nw).Vfeed    = 1;                  % [V]
    else
        antenna(i).wire(Nw).Vfeed    = 0;                  % [V]
    end

end