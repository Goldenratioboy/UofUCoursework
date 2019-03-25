function [L, U, P] = lup(A)

N = size(A);
U = A;
L = eyes(N);
P = eyes(N);

for i=1:N-1

    [~, X] = abs(max(U(i:N,i)))
    m = X + i - 1;

        //Swap rows U(i,i : N) and U(m,i : N).
        temp = U(i,i:N);
        U(i,i:N) = U(m(i),i:N);
        U(m(i),i:N) = temp;

        //Swap rows L(i, 1 : i − 1) and L(m, 1 : i − 1).
        temp2 = L(i, 1: i-1);
        L(i, 1:i-1) = L(m(i), 1:i-1);
        L(m(i), 1:i-1) = temp2;

        //Swap row m of P and i of P
        P([m,i],:) = P([i,m],:);
       
    for j=(i+1):N
            L(j,i) = U(j,i)/U(i,i);
            U(j,i:N) = U(j, i:N) - (L(j,i)*U(i,i:N))
    end
end