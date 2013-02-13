function [L, V, T, SL, SV, ST, N] = final_plot(R)
% tries a range of r's, plots avg path length and avg time.
s = size(R);
L = zeros(s);
V = zeros(s);
T = zeros(s);
SL = zeros(s);
SV = zeros(s);
ST = zeros(s);
N = zeros(s);


c = 1;
for r = R
     [l, v, t, sl, sv, st, n] = all_shots(r/1000);
     L(c) = l;
     V(c) = v;
     T(c) = t;
     SL(c) = sl;
     SV(c) = sv;
     ST(c) = st;
     N(c) = n;
     
     c = c+1;
end

figure
plot(R, L, 'r');
figure
plot(R, T, 'b');

end

