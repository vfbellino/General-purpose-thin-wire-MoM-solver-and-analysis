% This function computes the complex Poynting vector, given the fields E
% and H which spherical components are saved as struct variables. 
% In input the following is needed:

% 1) (E) The electric field components saved as structure variable 
% (in order: E.rad, E.azim, E.co_lat).
% 2) (H) The field components saved as structure variable 
% (in order: H.rad, H.azim, H.co_lat).

function [W] = POYNT(E,H)

Er = E.rad; Ep = E.azim; Et = E.co_lat;
Hr = H.rad; Hp = H.azim; Ht = H.co_lat;

Wr0 = Et.*conj(Hp) - Ep.*conj(Ht); Wp0 = Er.*conj(Ht) - Et.*conj(Hr); ...
    Wt0 = Ep.*conj(Hr) - Er.*conj(Hp); 

Wr = 0.5*Wr0; Wp = 0.5*Wp0; Wt = 0.5*Wt0;

W = struct('rad',Wr,'azim',Wp,'co_lat',Wt);