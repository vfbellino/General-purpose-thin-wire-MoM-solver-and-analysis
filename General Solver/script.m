tic

%% ============================================================
%  GENERAL PURPOUSE WIRE MoM SOLVER
%  ============================================================

root = fileparts(mfilename('fullpath'));
addpath(genpath(root));

%% ------------------------------------------------------------
%  CALL MEDIUM, GRID AND CONFIGURATION
%  ------------------------------------------------------------

grid = grid1();
medium = medium1();

% N = [31,61,91,121,151,181,211,241,271,301,331,361,...
%     391,421,451,481,511,541,571,601,631,661,691,721,751,...
%     781,811];

%N = 131;

%N = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,151,161,171,181,191];
%N = [301,401,501,601];

% N3 = 11:2:99;
% N2 = 101:5:196;
% N1 = 201:10:301;
% N = [N3,N2,N1,351,401,451,501,551,601,651,701,751,801,851,901];

%N = 11:2:41;

%N = 11:2:301;

%N = 301;

%N = 11:2:801;

N = 41:10:181;


for i = 1:length(N)

wire = GAConfigYagi3(medium,N(i));


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
%  BASIC CURRENT PLOTS
%  ------------------------------------------------------------

% figure
% hold on
% grid on
% 
% for i = 1:numel(wire)
% 
%     plot(geom.wire(i).sMid, ...
%          abs(sol.Iwire{i}), ...
%          'LineWidth',1.4)
% 
% end
% 
% xlabel('Local coordinate s [m]')
% ylabel('|I(s)| [A]')
% legend('Wire 1','Wire 2','Wire 3')

%% ------------------------------------------------------------
%  POST-PROCESSING
%  ------------------------------------------------------------

dB_bw = 10;
[W] = POYNT(E,H);
[~,P_rad,~] = POW(W,grid.rvec,grid.phvec,grid.thvec);
[Wav] = AVPOYNT(W);
[U,U0,FBR] = POWINT(Wav,grid.rvec,grid.phvec,grid.thvec);
[~,D0] = DIR(U,U0,P_rad);
[g0,p0,BW] = PATTERN(U,grid.rvec,grid.phvec,grid.thvec,dB_bw);
G0 = 10*log10(D0);
[Rin,Xin] = IMPEDANCEIN(sol,wire);
SLL = sideLobeLevel(U,grid.phvec,grid.thvec,pi/3);
[etaF,etaL,etaB] = radiationRegions(U,grid.phvec,grid.thvec);

gain0(i) = G0;
rin(i) = Rin;
xin(i) = Xin;
fbr(i) = FBR;
sll(i) = SLL;
etaf(i) = etaF;
etal(i) = etaL;
etab(i) = etaB;

end

%% ------------------------------------------------------------
%  BASIC INFORMATION
%  ------------------------------------------------------------

% fprintf('\nNumber of wires: %d\n',numel(wire));
% fprintf('Total MoM unknowns: %d\n',geom.Ntotal);
% fprintf('Frequency: %.6e Hz\n',medium.freq);
% fprintf('Wavelength: %.6f m\n',medium.lambda);
% fprintf('Wave number: %.6f rad/m\n',medium.wavenumb);
% fprintf('Intrinsic impedance: %.6f Ohm\n',medium.eta);
% 
% fprintf('\nMatrix condition number: %.6e\n',sol.condZ);
% fprintf('Linear-system residual: %.6e\n\n',sol.residual);

subplot(2,4,1)
plot(N,gain0)
%xlim([11 131])
title('N vs gain') 
subplot(2,4,2)
plot(N,rin)
%xlim([11 131])
title('N vs Rin')
subplot(2,4,3)
plot(N,xin)
%xlim([11 131])
title('N vs Xin')
subplot(2,4,4)
plot(N,fbr)
%xlim([11 131])
title('N vs FBR')
subplot(2,4,5)
plot(N,sll)
%xlim([11 131])
title('N vs SLL')
subplot(2,4,6)
plot(N,etaf)
%xlim([11 131])
title('N vs etaF')
subplot(2,4,7)
plot(N,etal)
%xlim([11 131])
title('N vs etaL')
subplot(2,4,8)
plot(N,etab)
%xlim([11 131])
title('N vs etaB')

toc
