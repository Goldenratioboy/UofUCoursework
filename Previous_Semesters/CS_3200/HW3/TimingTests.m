%% Timing Tests 

N = 75; %User can change N value here

A = rand(N, N);

[L, U, P] = lup(A); %LUP computation outside

time = zeros(N);
nrhsNumber = zeros (N);

for j=1:N
    nrhs = j;
    nrhsNumber(j) = nrhs;

    B = rand(N, nrhs);
    X = zeros (N, nrhs);

    %Loop through
    tic %Time for every number of right hand sides
    for i = 1: nrhs
        X(:,i) = bsub(U, fsub(L, P*B(:,i)));
    end
    toc

time(i) = toc;

end

plot(nrhsNumber, time)