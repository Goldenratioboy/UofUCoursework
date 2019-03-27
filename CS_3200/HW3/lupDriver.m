%%LUP Driver
N = 5;

nrhs = 4;

A = rand(N, N);
B = rand(N, nrhs);
X = zeros (N, nrhs);

[L, U, P] = lup(A);

%Loop through
for i = 1:nrhs
    X(:,i) = bsub(U, fsub(L, P*B(:,i)));
end

X2 = A\B;

%Relative Error
relativeError = norm(X-X2)./norm(X2);
disp(relativeError);
