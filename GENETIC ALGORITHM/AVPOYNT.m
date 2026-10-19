% This function computes the average power density (Wav) given the complex
% Poyinting vector.
% In input the following is needed:

% 1) (W) The Poynting vector components saved as structure variable 
% (in order: W.rad, W.azim, W.co_lat).

function [Wav] = AVPOYNT(W)

rWr = real(W.rad); rWp = real(W.azim); rWt = real(W.co_lat);...
    Wav = struct('rad',rWr,'azim',rWp,'co_lat',rWt);