% This function plots the relative error of the power radiated minus the
% power in input at the feed of the dipole, as a function of the number of
% points discretizing the angular coordinates phi and theta.
% In input the following is needed:

% 1) (lamb) dipole wavelength.
% 2) (zmid) middle points of the segments for the current.
% 3) (I) current on the dipole.
% 4) (feed) index of the feed on I.
% 5) (V0) tension of the delta gap.
% 6) (vec) vector of the number of points for angular the grid.
% 7) (type) the type of feed: delta-gap or magnetic frill 

function [err_mesh,epsilon_mesh] = EPSILONMESH(lamb,zmid,I,feed,V0,vec,type)

if type(1) == 0
    Ifeed = I(feed);
elseif type(1) == 1
    Ifeed = I(feed);
end
r = linspace(1000,1000,1);
P_in = 0.5*real(V0*Ifeed');
epsilon_mesh = zeros(1,length(vec));

for j = 1:length(vec)
    phi = linspace(0,2*pi,vec(j));
    tht = linspace(0.001,pi,vec(j));
    [E,H] = EMD(lamb,zmid,I,r,phi,tht);
    [W] = POYNT(E,H);
    [~,P_rad,~] = POW(W,r,phi,tht);
    epsilon_mesh(j) = abs(P_in-P_rad)/P_in;
end

figure(5)
    err_mesh = plot(vec,epsilon_mesh);
    title('Relative error of input and radiated power as function of the grid points')
    xlabel('number of points');
    ylabel('Relative error of input and radiated power');


