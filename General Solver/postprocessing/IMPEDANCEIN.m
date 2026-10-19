% This function plots the real and imaginary part of the input impedance
% for a dipole with a delta gap feed.
% In input the following is needed:

% 1) (fvec) vector of frequencies.
% 2) (l) length of the dipole.
% 3) (a) radius of the dipole a<<lamb.
% 4) (nseg) number of segmets for the dipole.
% 5) (V0) input tension of the delta gap.
% 6) (type) the type of feed: delta-gap or magnetic frill 

function [Rin,Xin] = IMPEDANCEIN(sol,wire)

Nw = numel(wire);

for i = 1:Nw
    V0 = wire(i).Vfeed;
    if V0 ~= 0
        idx = sol.feed{i};
        I = sol.Iwire{i};
        Ifeed = I(idx);
        Zin = V0/Ifeed;
        Rin = real(Zin);
        Xin = imag(Zin);
    else
        Zin = 0;
    end
end
