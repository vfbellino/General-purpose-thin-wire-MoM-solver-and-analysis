% This function converts the spherical components of a given vector field
% over R^3 into its Cartesian components (radial, co-latitude, azimut)

function [X, Y, Z, Fx, Fy, Fz] = FS2C(R, P, T, Fr, Ff, Ft)

s = @(a) sin(a); c = @(a) cos(a);
X = R.*s(T).*c(P); Y = R.*s(T).*s(P); Z = R.*c(T); 

Fx = s(T).*c(P).*Fr - s(P).*Ff + c(T).*c(P).*Ft;
Fy = s(T).*s(P).*Fr + c(P).*Ff + c(T).*s(P).*Ft;
Fz = c(T).*Fr - s(T).*Ft;












