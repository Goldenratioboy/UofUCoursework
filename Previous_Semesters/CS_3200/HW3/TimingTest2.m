%% Copy of TimingTest with LUP in different place
N = 75; % USER CHANGE N VALUE HERE

A = rand(N, N);


time = zeros(N);
nrhsNumber = zeros (N);

for j=1:N
    nrhs = j;
    nrhsNumber(j) = nrhs;

    B = rand(N, nrhs);
    X = zeros (N, nrhs);

    %Loop through
    tic % Time for every number of right hand sides
    for i = 1: nrhs
        [L, U, P] = lup(A); %Recompute Every time
        X(:,i) = bsub(U, fsub(L, P*B(:,i)));
    end
    toc

time(i) = toc;

end

plot(nrhsNumber, time)