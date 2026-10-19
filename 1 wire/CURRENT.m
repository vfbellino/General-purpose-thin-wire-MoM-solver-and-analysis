% This function computes the current distribution on a wire dipole of given
% length and radius and furnishes the plot for the absolute value, 
% of the current. The feed is at its center and it is modeled as a delta gap source. 
% In input, the following is required:

% 1) (lamb) wavelength of the radiated wave.
% 2) (l) the length of the dipole.
% 3) (a) the radius of the dipole a<<lamb.
% 4) (nseg) number of segments dividing the wire.
% 5) (V0) The voltage at the feed.
% 6) (doplot) Logical values to plot the current
% 7) (type) the type of feed: delta-gap or magnetic frill 

function [Z,I,i0,zmid,feed] = CURRENT(lamb,l,a,nseg,V0,doplot,type) 

e = 8.8541878128e-12;
k = 2*pi/lamb;
ome = k*physconst('LightSpeed');
dz = l/nseg;

znode = linspace(-l/2,l/2,nseg+1);
zmid = (znode(1:end-1)+znode(2:end))/2;

R = @(z,w) sqrt(a^2+(z-w).^2);
K = @(z,w) (exp(-1i*k*R(z,w))./(4*pi*R(z,w).^5)).*...
    ((1+1i*k*R(z,w)).*(2*R(z,w).^2-3*a^2)+(k*a*R(z,w)).^2);

for j = 1:nseg
    K_1 = @(w) K(-l/2+dz/2,w);
    s(j) =  integral(K_1,znode(j),znode(j+1));
end

c = s(:);
Z = toeplitz(c,c.'); Z = (1i/(ome*e))*Z;

if type(1) == 0
    V = zeros(nseg,1);
    feed = length(znode)/2;
    V(feed) = V0/dz;
elseif type(1) == 1
    feed = length(znode)/2;
    R1 = sqrt(zmid(:).^2 + a^2);
    R2 = sqrt(zmid(:).^2 + type(2)^2);
    V = (0.5*V0/log(type(2)/a))*(exp(-1i*k*R1)./R1 - exp(-1i*k*R2)./R2);
end

I = Z\V;

if doplot 
    figure(1)
    hold off
    i0 = plot(zmid,abs(I));
else
    i0 = [];
end

