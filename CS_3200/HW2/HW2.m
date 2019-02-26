%% HW 2 by Jonathan Pilling

%Problem 1 part a

syms x0 x1 x2 x f(x);
f(x) = x^2; %Sample function for testing

%Arbitrarily picked values
x0 = 1;
x1 = 2;
x2 = 10;

%Lagrange Values
l0 = ((x-x1)*(x-x2))/((x0-x1)*(x0-x2));
l1 = ((x-x0)*(x-x2))/((x1-x0)*(x1-x2));
l2 = ((x-x0)*(x-x1))/((x2-x0)*(x2-x1));

%Base polynomial interpolation function
Q = f(x0) * l0 + f(x1) * l1 + f(x2) * l2;

%Derivative of the approximation
Q_approx(x) = simplify(diff(Q,x));

%Finite Difference formulas for three points
h = 0.1; %Given 0.1 for testing
fd_x0 = (f(x0 + h) - f(x0 - h)) / 2*h;
fd_x1 = (f(x1 + h) - f(x1 - h)) / 2*h;
fd_x2 = (f(x2 + h) - f(x2 - h)) / 2*h;

%Part b
% Manipulating 5.3 equation so we equate to error term
Error = (f(x+h) - f(x))/h - Q_approx(x)

% Part C



%% Problem 2

%Here for example we'll calculate the error for an upside down parabola
%This is P(x)
syms f(x) f_approx(x) x x0 x1 x2
f(x) = -x^2 + 100;
x0 = -10;
x1 = 0;
x2 = 10;

%Lagrange Values
l0 = ((x-x1)*(x-x2))/((x0-x1)*(x0-x2));
l1 = ((x-x0)*(x-x2))/((x1-x0)*(x1-x2));
l2 = ((x-x0)*(x-x1))/((x2-x0)*(x2-x1));

f_approx(x) = f(x0) * l0 + f(x1) * l1 + f(x2) * l2;

%Derived Integral for x vs. approx of x
integralF = int(f(x),[-10,10]);
integralFApprox = int(f_approx(x),[-10,10]);

%Error for part b
Error = abs(integralF - integralFApprox)

%C is written response


