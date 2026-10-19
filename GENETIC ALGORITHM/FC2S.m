% This function converts the Cartesian components of a given vector field
% over R^3 into its spherical components (radial, co-latitude, azimut)

function [R, Phi, Th, Fr, Ff, Ft] = FC2S(X, Y, Z, Fx, Fy, Fz)

R = sqrt(X.^2 + Y.^2 + Z.^2); Th = acos(max(-1,min(1,Z./R)));
Phi = mod(atan2(Y,X),2*pi);

s = @(a) sin(a); c = @(a) cos(a);

Fr = s(Th).*c(Phi).*Fx + s(Th).*s(Phi).*Fy + c(Th).*Fz;
Ff = c(Phi).*Fy - s(Phi).*Fx;
Ft = c(Th).*c(Phi).*Fx + c(Th).*s(Phi).*Fy - s(Th).*Fz;