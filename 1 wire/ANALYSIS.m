% This function plots the input resistance, the input reactance, the power 
% radiated, the input power and the maximum directivity as function of the
% number of segments of the wire (vecseg).
% In input the following is needed:

% 1) (lamb) the dipole wavelengh.
% 2) (l) the dipole length.
% 3) (a) the dipole radius.
% 4) (f) frequency of the dipole.
% 5) (V0) the voltage of the delta gap.
% 6) (vecseg) the vector of segments for the current.
% 7) (r) the vector of radius.
% 8) (phi) the vector of azimuth angles.
% 9) (tht) the vector of co-latitude angles.
% 10) (type) the type of feed: delta-gap or magnetic frill 


function [G] = ANALYSIS(lamb,l,a,f,V0,vecseg0,r,phi,tht,type)

doplot = 0;

Zin0 = zeros(1,length(vecseg0));
Prad0 = zeros(1,length(vecseg0));
Pin0 = zeros(1,length(vecseg0));
D00 = zeros(1,length(vecseg0));

for j = 1:length(vecseg0)
    [~,Zin,~,~] = IMPEDANCEIN(f,l,a,vecseg0(j),V0,type);
    Zin0(j) = Zin;

    [~,I,~,zmid,feed] = CURRENT(lamb,l,a,vecseg0(j),V0,doplot,type);
    [E,H] = EMD(lamb,zmid,I,r,phi,tht);
    [W] = POYNT(E,H);
    [~,P_rad,~] = POW(W,r,phi,tht);
    [Wav] = AVPOYNT(W);
    [U,U0,~,~] = POWINT(Wav,r,phi,tht);
    [~,D0] = DIR(U,U0,P_rad);

    Prad0(j) = P_rad;
    if type(1) == 0
        Pin0(j) = 0.5*real(V0*I(feed)');
    elseif type(1) == 1
        Pin0(j) = 0.5*real(V0*I(feed)');
    end
    D00(j) = D0;
end

Rin0 = real(Zin0); Xin0 = imag(Zin0);

figure(8)
G = subplot(2,2,1);
    plot(vecseg0,Rin0,vecseg0,Xin0);
    subplot(2,2,2);
    plot(vecseg0,Prad0);
    subplot(2,2,3);
    plot(vecseg0,Pin0);
    subplot(2,2,4)
    plot(vecseg0,D00);
 


   



