%% Back Substitution Function Algorithm 4 in Notes
function [x] = bsub(U, y)

[~,N] = size(U); %Take 1 dimension of U put it in N

x = zeros(N,1); %1D Array for X of zeros

x(N) = y(N)/U(N,N);

for i=N-1:-1:1
    x(i) = (y(i)-U(i,i+1:N)*x(i+1:N))/U(i,i);
end