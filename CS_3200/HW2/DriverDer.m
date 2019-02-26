%% Driver Der File

% Anonymous function for testing
anon_f = @(x) x^2 + 10;

syms f(x)
f(x) = x^2 + 10;

xPlot = zeros(1,1000);
yPlot = zeros(1,1000);
yValues = zeros(1,1000);

%Gives us list of function inputs and outputs
for i=1:1000
    xPlot(i) = i;
    yValues(i) = anon_f(i);
end

%Approx Derivatives
yPlotApprox = FirstDer(xPlot, yPlot);

%Calculating Actual Derivatives
for(i=1:length(yPlot))
    yPlot(i) = abs(diff(f(i),x)-yValues(i)); %Subtracting the derivative from approx
end

plot(xPlot, yPlot)