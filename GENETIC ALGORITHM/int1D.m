% This function computes the 2D integral of a given function using its
% points of evaluation on a specified grid. The domain of integration is
% bounded and this can be useful to integrate power intensities of
% antennas over the solid angle.

function [I] = int1D(x,W)
a = min(x); b = max(x);
C = ((b-a)/length(x));
S = 0;

for i = 1:length(x)
    S = S + sum(W(i));
end

I = C*S;



