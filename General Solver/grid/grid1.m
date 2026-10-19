%% ------------------------------------------------------------
%  GRID
%  ------------------------------------------------------------

function grid = grid1() 

grid.N     = 100;
grid.rvec  = 1000;
grid.phvec = linspace(0,2*pi,100);
grid.thvec = linspace(0,pi,100);
[grid.rmesh,grid.phmesh,grid.thmesh] = ...
    meshgrid(grid.rvec,grid.phvec,grid.thvec);
