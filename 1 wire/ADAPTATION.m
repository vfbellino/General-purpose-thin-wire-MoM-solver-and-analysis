% This function computes the reflection coefficient (Gamma), the
% adaptation frequency (fa) and the BandWidth (BW) for a given line 
% impedance (Z0) and plots the reflection coefficient in deciBell.

% In input the following is needed:
% 1) (fvec) vector of frequencies.
% 2) Zvec_in vector of the input impedance as function of (fvec).
% 3) (Z0) Impedance of the transmission line.

function [u0,Gamma,fa,FBW] = ADAPTATION(fvec,Zvec_in,Z0)

Gamma = (Zvec_in - Z0)./(Zvec_in + Z0);
S11_dB = 20*log10(abs(Gamma));

[~,adapt] = min(abs(Gamma));
fa = fvec(adapt);

ind = find(S11_dB <= -10);
fL = fvec(ind(1)); fH = fvec(ind(end));

FBW = 100*(fH - fL)/(0.5*(fH + fH));

figure(4)
u0 = plot(fvec./10^6,S11_dB);
title('Reflection coefficient as function of the frequency')
xlabel('Frequencies (MHz)')
ylabel('S_{11} [dB]');

