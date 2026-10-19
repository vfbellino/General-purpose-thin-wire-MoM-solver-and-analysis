function Obj = objFun1(wire,initGA)

a = initGA.objParam.Gain;
b = initGA.objParam.RealImp;
c = initGA.objParam.ImagImp;
d = initGA.objParam.FBR;
e = initGA.objParam.SLL;
f = initGA.objParam.etaF;
g = initGA.objParam.etaL;
h = initGA.objParam.etaB;


[G0,FBR,SLL,etaF,etaL,etaB,Rin,Xin] = solverGA(wire);

% Obj = a*G0 - b*abs(50-Rin) - c*abs(Xin) + d*FBR;

Obj = a*G0 - b*max(0,abs(50-Rin)-20)^2 - ...
    c*max(0,abs(Xin)-20)^2 + d*FBR - e*SLL + ...
    f*etaF - g*etaL - h*etaB;
