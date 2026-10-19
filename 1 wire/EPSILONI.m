% This function plots the relative error of the power radiated minus the
% power in input at the feed of the dipole, as a function of the number of
% segments discretizing the current on the dipole.
% In input the following is needed:

% 1) (lamb) the dipole wavelengh.
% 2) (l) the dipole length.
% 3) (a) the dipole radius.
% 4) (P_rad) the power radiated,
% 5) (V0) the voltage of the delta gap.
% 6) (vecseg) the vector of segments for the current.
% 7) (type) the type of feed: delta-gap or magnetic frill 

function [err_I,epsilon_I] = EPSILONI(lamb,l,a,V0,vecseg,r,phi,tht,type)

doplot = 0;

for j = 1:length(vecseg)
    [~,I,~,zmid,feed] = CURRENT(lamb,l,a,vecseg(j),V0,doplot,type);
    [E,H] = EMD(lamb,zmid,I,r,phi,tht);
    [W] = POYNT(E,H);
    [~,P_rad,~] = POW(W,r,phi,tht);
    if type(1) == 0
        Ifeed = I(feed);
        P_in =  0.5*real(V0*Ifeed');
    elseif type(1) == 1
        Ifeed = I(feed);
        P_in =  0.5*real(V0*Ifeed');
    end
    epsilon_I(j) = abs(P_in-P_rad)/P_in;
end

figure(6)
err_I = plot(vecseg,epsilon_I);
title('Relative error of input and radiated power as function of the current segments')
xlabel('number of segments');
ylabel('Relative error of input and radiated power');