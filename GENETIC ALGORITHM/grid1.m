%% ------------------------------------------------------------
%  GRID
%  ------------------------------------------------------------

function grid = grid1() 

grid.N     = 1;
grid.rvec  = 1000;
grid.phvec = linspace(0,2*pi,50);
grid.thvec = linspace(0,pi,50);
[grid.rmesh,grid.phmesh,grid.thmesh] = ...
    meshgrid(grid.rvec,grid.phvec,grid.thvec);
