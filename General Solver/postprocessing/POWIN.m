function P_in = POWIN(sol)

Nw = numel(sol.Iwire);

for i = 1:Nw
    feed = sol.feed{i};
    Ifeed = sol.Iwire{i};
    Ifeedvec(i) = Ifeed(feed);
    Vfeedvec(i) = sol.V{i};
end

Vfeedvec = Vfeedvec(:)';
Ifeedvec = Ifeedvec(:);

P_in = 0.5*real(Vfeedvec*conj(Ifeedvec));

