% This function plots the radiation pattern of an infinitesimal dipole
% given the radiation intensity (U).
% In input the following is needed:

% 1) (U) The radiation intensity.
% 2) (r) The radii vector.
% 3) (phi) The azimuth angles vector.
% 4) (tht) The co-latitude angles vector.

function [g0,p0,p1,BW] = PATTERN(U,r,phi,tht,dB_bw) 

[R,PHI,THT] = meshgrid(r,phi,tht);

[~,N,L] = size(R);

RU(:,:) = U(:,N,:);
PHI0(:,:) = PHI(:,N,:);
THT0(:,:) = THT(:,N,:);

RU_db = 10*log10(RU);
RU_db(RU_db < -80) = -80;

RU_db = RU_db + 80;

X = RU_db.*cos(PHI0).*sin(THT0);
Y = RU_db.*sin(PHI0).*sin(THT0);
Z = RU_db.*cos(THT0);

figure(3)
g0 = surf(X,Y,Z); title('Far region: Radiation Pattern');...
    xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis');

RUmag(:) = RU(1,:);
tht2 = [tht(1:L-1),tht+pi];
RUmag2(:) = [RUmag(1:L-1),RUmag];
RUmag2_db = 10*log10(RUmag2/max(RUmag2));
RUmag2_db(RUmag2_db < -40) = -40;

[~,idx] = min(abs(tht(:)-pi/2));

RUmag3(:) = RU(:,idx);
RUmag3_db = 10*log10(RUmag3/max(RUmag3));
RUmag3_db(RUmag3_db < -40) = -40;


[~,ind] = min(abs(RUmag2_db(1:L-1)+dB_bw));

BW = abs(rad2deg(pi-2*tht(ind)));

figure(4)
p0 = polarplot(tht2,RUmag2_db); rlim([-40 0]);...
    title('Far region: Elevation plane amplitude pattern');...
    pax = p0.Parent; ...
    text(pi/10, -10, "Relative Power (db down)", 'Parent', p0.Parent);...
    p0.LineWidth = 2.5; ...
    pax.ThetaZeroLocation = 'top';...
    pax.ThetaDir = 'clockwise';...
    thetaticks([0 30 60 90 120 150 180 210 240 270 300 330]);
    thetaticklabels({'0°', '30°', '60°', '90°', '120°', '150°', '180°', ...
        '150°', '120°', '90°', '60°', '30°'});

figure(5)
p1 = polarplot(phi,RUmag3_db); rlim([-40 0]);
    title('Far region: Azimuth plane amplitude pattern');...
        p1.LineWidth = 2.5;
