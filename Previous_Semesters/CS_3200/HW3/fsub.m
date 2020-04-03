%% Forward Substitution Algorithm 3 in Notes
function [y] = fsub(L,d)

y = d;
N = size(L);

for i=2:N
    y(i) = d(i) - L(i,1:i-1)*y(1:i-1);
end