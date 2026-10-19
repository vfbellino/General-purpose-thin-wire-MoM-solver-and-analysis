% This function computes the radiation intensity of an infinitesimal dipole
% in the far field region along with its maximum value and the direction of
% the maximum.
% In input the following is needed:

% 1) (Wav) The average Poynting vector.
% 2) (r) The radii vector.
% 3) (phi) The azimuth angles vector.
% 4) (tht) The co-latitude angles vector.

function [U,U0,FBR] = POWINT(Wav,r,phi,tht)

Wavr = Wav.rad; [~,N,~] = size(Wavr); 
U(:,1:N,:) = r.^2.*Wavr(:,1:N,:);

[U0,ind] = max(U(:)); [j0,n0,k0] = ind2sub(size(U),ind);
phi0 = phi(j0); tht0 = tht(k0);

%Dir opposta
phiB = mod(phi0+pi,2*pi);
thtB = pi-tht0;

%Griglia find
[~,jB] = min(abs(phi-phiB));
[~,kB] = min(abs(tht-thtB));

% Int rad
UB = U(jB,n0,kB);

FBR = 10*log10(U0/UB);

