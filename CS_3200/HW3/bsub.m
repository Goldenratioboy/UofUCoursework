function [x] = bsub(U, y)

N = size(U);
x = zeros(N);

x(N) = y(N) ./ U(N,N);

for i = N-1:-1:1
    x(i) = (y(i) − U (i, i + 1 : N ) ∗ x(i + 1 : N ))/U (i, i);
end