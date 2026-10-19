% This function plots and computes the conditioning of the impedance MoM
% matrix as function of the number of segments (vecseg).

% 1) (lamb) the dipole wavelengh.
% 2) (l) the dipole length.
% 3) (a) the dipole radius.
% 4) (V0) the voltage of the delta gap.
% 5) (vecseg) the vector of segments for the current.
% 6) (type) the type of feed: delta-gap or magnetic frill 

function [c_Z,condvec] = CONDZ(lamb,l,a,V0,vecseg,type)

doplot = 0;
condvec = zeros(size(vecseg));

for j = 1:length(vecseg)
    [Z,~,~,~,~] = CURRENT(lamb,l,a,vecseg(j),V0,doplot,type);
    condvec(j) = cond(Z);
end

figure(7)
c_Z = semilogy(vecseg,condvec,'o-');
grid on
xlabel('Numero di segmenti')
ylabel('cond(Z)')
title('Condizionamento della matrice MoM')