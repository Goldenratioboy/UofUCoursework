N = 75;

A = rand(N, N);

[L, U, P] = lup(A);

time = zeros(N);
nrhsNumber = zeros (N);

for j=1:N
    nrhs = j;
    nrhsNumber = nrhs;

    B = rand(N, nrhs);
    X = zeros (N, nrhs);

    %Loop through
    tic
    for i = 1: nrhs
        temp = fsub(L, P*B(:,i));
        X(:,i) = bsub(U, temp);
    end
    toc

time(i) = toc;

end

plot(nrhsNumber, time)