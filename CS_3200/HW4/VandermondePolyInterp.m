clear; 
clc;

%% Define the unknown function to interpolate
f = @(x) sin(x) + 0.1*rand(length(x),1);

%% Numbers of data points.
Nd = 40; % Change this value

for i=1:3

    %% User defined l value
    l = i; %This will give 1,2
    if i == 3 %This will give Nd-1
        l = Nd - 1;
    end
    
    %% Setup the points at which we want to evaluate the interpolant
    xe = linspace(-1,1,10000)'; %generate evenly-spaced points
    ye = f(xe); %evaluate function

    %% Start plotting stuff
    figure
    plot(xe,ye,'black');
    %pause %waits for input

    x = linspace(-1,1,Nd)'; %generate evenly-spaced points in [-1,1].
    y = f(x);

    %% Form Vandermonde matrix "intelligently"
    V = zeros(Nd,Nd);
    for vit = 1:Nd
        V(:,vit) = x.^(vit-1);
    end

    %% Compute coefficients by QR decomposition.
    [Q,R] = qr(V); % Computing coefficients by QR
    display(Q)
    display(R)
    %a = V\y;
    a = R \ (Q' * y);
    %% Evaluate polynomial interpolant by building eval matrix and
    %% multiplying with coefficients.
    Ve = zeros(length(xe),Nd);
    for vit = 1:l 
        Ve(:,vit) = xe.^(vit-1);
    end
    ye_num = Ve*a; %Do the matrix-vector product to predict values

    %% Plot stuff
    hold on;
    plot(xe,ye_num,'-');
    drawnow
end
%pause


    
    