%% Back Substitution Function Algorithm 4 in Notes
function [x] = bsub(U, y)

N = size(U);

x = zeros(N);

%Display Statements
disp(size(y))
disp(size(U(N,N)))
disp(size(U))

x(N) = y(N)/U(N,N);

for i=N-1:-1:1
    x(i) = (y(i)-U(i,i+1:N)*x(i+1:N))/U(i,i);
end