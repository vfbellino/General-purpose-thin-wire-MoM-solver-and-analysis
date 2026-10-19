% This function computes the complex power moving in the radial direction.
% It explicitly givens the power radiated (P_rad) and the reactive 
% power (P_reac) in the radial direction, for any value of the r
% vector.
% In input the following is needed: 

% 1) (W) The Poynting vector saved as structure variable (in order: W.rad, 
% W.azim, W.co_lat).
% 2) (r) vector of radii.
% 3) (phi) vector of azimuthal angles.
% 4) (tht) vector of co-latitude angles.

function [P,P_rad,P_reac] = POW(W,r,phi,tht)

Wr = W.rad; [m,n,l] = size(Wr); Wri = zeros(m,l);
[~,~,THT] = meshgrid(r,phi,tht); THTi(:,:) = THT(:,1,:);
P = zeros(1,n);

for j = 1:n
    Wri(:,:) = Wr(:,j,:);
    F = Wri.*sin(THTi)*r(j)^2;
    I = int2D(tht,phi,F);
    P(j) = I;
end

P_rad = real(P);
P_reac = imag(P); 

