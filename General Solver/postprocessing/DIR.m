% This function computes the directivity (D) of an infinitesimal dipole
% along with the maximum directivity (D0).
% In input the following is needed:

% 1) (U) The radiation intensity.
% 2) (U0) The maximum radiation intensity.
% 3) (P_rad) The power radiated by the dipole in the far field.

function [D,D0] = DIR(U,U0,P_rad)

D = 4*pi*U/P_rad;
D0 = 4*pi*U0/P_rad;