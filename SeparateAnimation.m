function SeparateAnimation () 
    %% V 
    X3 = linspace(-2,2); %Creating a space for the vector field to exist in.
    Y3 = X3; % Setting linspace Y boundaries = to x. 
    [xTemp,yTemp] = meshgrid(X3, Y3); % Creating a meshgrid in order to make a grid for a vector field to exist on. 
    u = -yTemp; % Settingn up the i portion of the vector field (which measures density.)
    v = .5*xTemp; %Setting up the j portion of the vector field (which measures density.) 

 %% DivGrad - Grad*V    
     dx = 0;
     dy = 0;
     X = linspace(-2, 2); %X boundaries
     Y = X; %Setting Y boundaries using the X boundaries.
     U0 = zeros(100,100); %Creating a matrix for the output.
     
     function res = Udipole(t,x,y) %Setting up the initial density field.
         res = [0.5* log(((x - 1)^2 + y^2))]; %This is the equation for it.
     end
     for i = 1: 100 % Incrementing through the field
        for j = 1:100 %By both axes
         U0(i,j) = Udipole(0, X(i), Y(j)); %Creating the Udipole field as a part of ....
        end
     end 
     U0 = reshape(U0,[10000,1]); % Making U20 into a vector so it can be used in ODE45 
     %Convert to matrix
     function concentrationdT = Divgrad(~, V) %Creating the equation that will execute divgrad
           V = reshape(V,[100,100]); %Formatting everything back into a square matrix.
           [dx, dy] = gradient(V); %Taking the grad of the matrix.
           concentrationdT = divergence(dx,dy); %Taking the divergence of the grad to finish divgrad.
           for i = 1:100 % Iterating through the outcome in order to subtract the velocity*grad 
               for j = 1:100
                  concentrationdT(i,j) = concentrationdT(i,j) - [dx(i,j), dy(i,j)]*[u(i,j);v(i,j)]; %subtracting grad*velocity from the divgrad
               end
           end 
           concentrationdT = reshape(concentrationdT,[10000, 1]); % Putting everything back into vector form for ODE45
     end 
 
     [t,concentrationArray] = ode45(@Divgrad, linspace(0,100), U0); %Taking ODE45 to solve the differential equation.
     subplot(1,2,1)
     for i = 1: length(t) 
         axis([-10 10 -10 10 -5 5]); %axis([xMin xMax yMin yMax]); 
         pause(.1);
         U1 = reshape(concentrationArray(i,:), [100 100]);
         surf(linspace(-10,10),linspace(-10,10),U1,'EdgeColor','none')
     end

 %% DivGrad - Grad*V    
     dx2 = 0;
     dy2 = 0;
     X2 = linspace(-2, 2); %X boundaries
     Y2 = X2; %Setting Y boundaries using the X boundaries.
     U20 = zeros(100,100); %Creating a matrix for the output.
     
     function res = Udipole2(t,x,y) %Setting up the initial density field.
         res = [0.5* log(((x - 2)^2 + y^2))]; %This is the equation for it.
     end
     for i = 1: 100 % Incrementing through the field
        for j = 1:100 %By both axes
         U20(i,j) = Udipole2(0, X2(i), Y2(j)); %Creating the Udipole field as a part of ....
        end
     end 
     U20 = reshape(U20,[10000,1]); % Making U20 into a vector so it can be used in ODE45 
     %Convert to matrix
     function concentrationdT = Divgrad2(~, V2) %Creating the equation that will execute divgrad
           V2 = reshape(V2,[100,100]); %Formatting everything back into a square matrix.
           [dx2, dy2] = gradient(V2); %Taking the grad of the matrix.
           concentrationdT = divergence(dx2,dy2); %Taking the divergence of the grad to finish divgrad.
           for i = 1:100 % Iterating through the outcome in order to subtract the velocity*grad 
               for j = 1:100
                  concentrationdT(i,j) = concentrationdT(i,j) - [dx2(i,j), dy2(i,j)]*[u(i,j);v(i,j)]; %subtracting grad*velocity from the divgrad
               end
           end 
           concentrationdT = reshape(concentrationdT,[10000, 1]); % Putting everything back into vector form for ODE45
     end 
 
     [t,concentrationArray] = ode45(@Divgrad2, linspace(0,100), U20); %Taking ODE45 to solve the differential equation.
     subplot(1,2,2)
     for i = 1: length(t) 
         axis([-10 10 -10 10 -5 5]); %axis([xMin xMax yMin yMax]); 
         pause(.1);
         U1 = reshape(concentrationArray(i,:), [100 100]);
         surf(linspace(-10,10),linspace(-10,10),U1,'EdgeColor','none')
     end
end