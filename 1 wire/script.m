%clear all; clc;

lamb = 0.6;
lz = 0.5*lamb;
a = 3e-4;

%type = [0,0];
type = [1,sqrt(1.1)*a];

% r = linspace(1000,1000,1);
% phi = linspace(0,2*pi,100);
% tht = linspace(0.001,pi,100);

V0 = 1; dB_bw = 10; doplot = 0;

nseg = [11,31,51,101,101,401];

for n = 1:length(nseg)
[~,I,i0,zmid,feed] = CURRENT(lamb,lz,a,nseg(n),V0,doplot,type);
IWire(n).nseg = I;
IWire(n).zmid = zmid;
end

for i = 1:length(nseg)
figure(1)
plot(IWire(i).zmid/lz,abs(IWire(i).nseg))
hold on
end

% [E,H] = EMD(lamb,zmid,I,r,phi,tht);
% [W] = POYNT(E,H);
% [~,P_rad,~] = POW(W,r,phi,tht);
% [Wav] = AVPOYNT(W);
% [U,U0,phi0,tht0] = POWINT(Wav,r,phi,tht);
% [~,D0] = DIR(U,U0,P_rad);
% [g0,p0,BW] = PATTERN(U,r,phi,tht,dB_bw); 
% 
% c = physconst('LightSpeed');
% lamb0 = 1;
% l0 = 0.5*lamb0;
% a = lamb/1000;
% fhalf = c/lamb0;
% fvec = linspace(0.8*fhalf,1.2*fhalf,1000);
% lambvec = c./fvec;
% V0 = 1;
% [g,Zvec_in,fr,Rfr] = IMPEDANCEIN(fvec,l0,a,nseg,V0,type);
% Z0 = 50;
% [u0,Gamma,fa,FBW] = ADAPTATION(fvec,Zvec_in,Z0);
% 
% vec = linspace(100,1000,100);
% [err_mesh,epsilon_mesh] = EPSILONMESH(lamb,zmid,I,feed,V0,vec,type);
% vecseg = 551:200:1501;
% [err_I,epsilon_I] = EPSILONI(lamb,lz,a,V0,vecseg,r,phi,tht,type);
% [c_Z,condvec] = CONDZ(lamb,lz,a,V0,vecseg,type);
% 
% vecseg0 = 251:10:351;
% vecseg0 = 101:100:901;
% f = c/lamb;
% [G] = ANALYSIS(lamb,lz,a,f,V0,vecseg0,r,phi,tht,type);
