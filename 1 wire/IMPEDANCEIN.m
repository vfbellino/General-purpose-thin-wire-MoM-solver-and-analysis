% This function plots the real and imaginary part of the input impedance
% for a dipole with a delta gap feed.
% In input the following is needed:

% 1) (fvec) vector of frequencies.
% 2) (l) length of the dipole.
% 3) (a) radius of the dipole a<<lamb.
% 4) (nseg) number of segmets for the dipole.
% 5) (V0) input tension of the delta gap.
% 6) (type) the type of feed: delta-gap or magnetic frill 

function [g,Zvec_in,fr,Rfr] = IMPEDANCEIN(fvec,l,a,nseg,V0,type)

c = physconst('LightSpeed');
lambvec = c./fvec;
doplot = 0;

Zvec_in = zeros(1,length(lambvec));

for j = 1:length(lambvec)
    [~,I,~,~,feed] = CURRENT(lambvec(j),l,a,nseg,V0,doplot,type);
    if type(1) == 0
        Zvec_in(j) = V0/I(feed);
    elseif type(1) == 1
        Zvec_in(j) = V0/I(feed);
    end
end

Rvec_in = real(Zvec_in);
Xvec_in = imag(Zvec_in);

[~,ind] = min(abs(Xvec_in(:)));
fr = fvec(ind);
Rfr = Rvec_in(ind);

figure(3)
title('Input resistance and Input reactance as function of frequencies')
g(1) = plot(fvec/10^6,Rvec_in);
    hold on;
g(2) = plot(fvec/10^6,Xvec_in); legend('R_{in}','X_{in}');
xlabel('Frequencies (MHz)'), ylabel('Ohm (\Omega)')


