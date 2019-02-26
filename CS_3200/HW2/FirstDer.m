function [ Output ] = FirstDer( x, y )
%FIRSTDER Accepts set of all inputs x, and the values at those points y

%Set size of output
Output = zeros(1,length(x));

for i = 1:3:length(x)
    %Grabs the x values from x
    
    %Assure that we do not go out of bounds
    if(i+2 < length(x))
       x0 = x(i);
       x1 = x(i+1);
       x2 = x(i+2); 
      
    %Lagrange Values
    l0 = ((x(i)-x1)*(x(i)-x2))/((x0-x1)*(x0-x2));
    l1 = ((x(i)-x0)*(x(i)-x2))/((x1-x0)*(x1-x2));
    l2 = ((x(i)-x0)*(x(i)-x1))/((x2-x0)*(x2-x1));
    
    %Compute Outputs three at a time
    Output(i) = y(i) * l0 + y(i) * l1 + y(i) * l2;
    Output(i+1) = y(i+1) * l0 + y(i+1) * l1 + y(i+1) * l2;
    Output(i+2) = y(i+2) * l0 + y(i+2) * l1 + y(i+2) * l2;
    end
    
        
end
end


