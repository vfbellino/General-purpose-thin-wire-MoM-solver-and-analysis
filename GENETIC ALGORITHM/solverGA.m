function [G0,FBR,SLL,etaF,etaL,etaB,Rin,Xin] = solverGA(wire)


root = fileparts(mfilename('fullpath'));
addpath(genpath(root));

%% ------------------------------------------------------------
%  CALL MEDIUM AND GRID 
%  ------------------------------------------------------------

grid = grid1();
medium = medium1();

%% ------------------------------------------------------------
%  BUILD GEOMETRY
%  ------------------------------------------------------------

geom = buildGeometry(wire);

%% ------------------------------------------------------------
%  ASSEMBLE MoM SYSTEM
%  ------------------------------------------------------------

[Z,V,loss,feedvec] = assembleMoM(wire,geom,medium);

%% ------------------------------------------------------------
%  SOLVE MoM SYSTEM
%  ------------------------------------------------------------

sol = solveMoM(Z,V,loss,feedvec,wire,geom);

%% ------------------------------------------------------------
%  SOLVE FIELDS
%  ------------------------------------------------------------

[E,H] = totalField(sol,wire,geom,medium,grid);

%% ------------------------------------------------------------
%  POST-PROCESSING
%  ------------------------------------------------------------

[W] = POYNT(E,H);
P_ohm = POWOHM(wire,sol,geom);
P_in = POWIN(sol);
P_rad = P_in - P_ohm;
[Wav] = AVPOYNT(W);
[U,U0,FBR] = POWINT(Wav,grid.rvec,grid.phvec,grid.thvec);
[~,D0] = DIR(U,U0,P_rad);
[Rin,Xin] = IMPEDANCEIN(sol,wire);
ecd = P_rad/(P_rad + P_ohm);
G0 = 10*log10(ecd*D0);
[SLL] = sideLobeLevel(U,grid.phvec,grid.thvec,pi/2);
[etaF,etaL,etaB] = radiationRegions(U,grid.phvec,grid.thvec);

