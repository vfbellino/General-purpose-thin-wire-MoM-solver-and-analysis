tic


% clc;
% clear all;

medium = medium1();
lamb   = medium.lambda;

initGA.Npop              = 500;
initGA.Nbits             = 8;
initGA.lowbound          = lamb*[0.45; 0.35; 0.25; 0.20; 0.20];
initGA.upbound           = lamb*[0.60; 0.50; 0.40; 0.50; 0.50];
initGA.objParam.Gain     = 0;
initGA.objParam.RealImp  = 3;
initGA.objParam.ImagImp  = 3;
initGA.objParam.FBR      = 0;
initGA.objParam.SLL      = 0;
initGA.objParam.etaF     = 7500;
initGA.objParam.etaL     = 10000;
initGA.objParam.etaB     = 1000000;
initGA.probCross         = 0.8;
initGA.probMut           = 0.001;
initGA.Ngen              = 200;

N = length(initGA.lowbound);
chromosome = randi([0 1], initGA.Npop, initGA.Nbits*N);

for i = 1:initGA.Ngen
    population = buildLengths(initGA,chromosome);
    [copies,rem] = copyNumber(medium,initGA,population);
    matPool = matingPool(copies,rem,population);
    chromosome = mating(initGA,matPool);
end

population = buildLengths(initGA,chromosome);
antenna = configYagi(medium,population);

for i = 1:initGA.Npop
    wire0 = antenna(i).wire;
    OBJ(i) = objFun1(wire0,initGA);
end

[bestObjective, idx] = max(OBJ);
bestChromosome = population.element(idx);

wire = antenna(idx).wire;

clearvars -except wire

%% ------------------------------------------------------------
%  CALL MEDIUM AND GRID 
%  ------------------------------------------------------------

gri = grid1();
medium = medium1();

% % ------------------------------------------------------------
%  BUILD GEOMETRY
%  ------------------------------------------------------------

geom = buildGeometry(wire);

figure
hold on
grid on
box on

Nw = numel(wire);

for i = 1:Nw

    N = vertcat(wire.Nseg);
    r = geom.wire(i).rMid;

    plot3(r(1:N(i),1), ...
        r(1:N(i),2), ...
        r(1:N(i),3), ...
        '.-', ...
        'LineWidth',2, ...
        'MarkerSize',10);

end

xlabel('x [m]')
ylabel('y [m]')
zlabel('z [m]')

axis equal
view(45,25)

% % ------------------------------------------------------------
%  ASSEMBLE MoM SYSTEM
%  ------------------------------------------------------------

[Z,V,loss,feedvec] = assembleMoM(wire,geom,medium);

% % ------------------------------------------------------------
%  SOLVE MoM SYSTEM
%  ------------------------------------------------------------

sol = solveMoM(Z,V,loss,feedvec,wire,geom);

% % ------------------------------------------------------------
%  SOLVE FIELDS
%  ------------------------------------------------------------

[E,H] = totalField(sol,wire,geom,medium,gri);

% % ------------------------------------------------------------
%  POST-PROCESSING
%  ------------------------------------------------------------

[W] = POYNT(E,H);
P_ohm = POWOHM(wire,sol,geom);
P_in = POWIN(sol);
P_rad = P_in - P_ohm;
[Wav] = AVPOYNT(W);
[U,U0,FBR] = POWINT(Wav,gri.rvec,gri.phvec,gri.thvec);
[~,D0] = DIR(U,U0,P_rad);
[Rin,Xin] = IMPEDANCEIN(sol,wire);
ecd = P_rad/(P_rad + P_ohm);
G0 = 10*log10(ecd*D0);
SLL = sideLobeLevel(U,gri.phvec,gri.thvec,pi/2);
[etaF,etaL,etaB] = radiationRegions(U,gri.phvec,gri.thvec);


toc