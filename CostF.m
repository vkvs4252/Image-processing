
function [z, out] = CostF(m, X)
d = pdist2(X, m);
[dmin, ind] = min(d, [], 2);
WCD = sum(dmin);
z=WCD;
out.d=d;
out.dmin=dmin;
out.ind=ind;
out.WCD=WCD;
end