%%LUP Function Algorithm 2 in Notes
function [L, U, P] = lup(A)

N = size(A); %N is size of A
U = A;
L = eye(N);
P = eye(N); %Identity Matrices

for i=1:N-1

    [~, X] = max(abs(U(i:N,i)));%Results in maximum index of largest column element in abs value
    m = X + i - 1; %Off by 1 so decrement here

        %Swap rows U(i,i : N) and U(m,i : N).
        temp = U(i,i:N);
        U(i,i:N) = U(m,i:N);
        U(m,i:N) = temp;

        %Swap rows L(i, 1 : i − 1) and L(m, 1 : i − 1).
        temp2 = L(i, 1: i-1);
        L(i, 1:i-1) = L(m, 1:i-1);
        L(m, 1:i-1) = temp2;

        %Swap row m of P and i of P
        P([m,i],:) = P([i,m],:);
     
     %Perform L and U computations
    for j=(i+1):N
            L(j,i) = U(j,i)/U(i,i);
            U(j,i:N) = U(j, i:N) - (L(j,i)*U(i,i:N));
    end
end