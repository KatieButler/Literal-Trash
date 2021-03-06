function FinalAnimation () 
    %% V 
    X3 = linspace(-2,2); %Creating a space for the vector field to exist in.
    Y3 = X3; % Setting linspace Y boundaries = to x. 
    [xTemp,yTemp] = meshgrid(X3, Y3); % Creating a meshgrid in order to make a grid for a vector field to exist on. 
    u = -yTemp; % Settingn up the i portion of the vector field (which measures density.)
    v = .5*xTemp; %Setting up the j portion of the vector field (which measures density.) 

 %% DivGrad - Grad*V    
     dx2 = 0;
     dy2 = 0;
     X2 = linspace(-2, 2); %X boundaries
     Y2 = X2; %Setting Y boundaries using the X boundaries.
     U20 = zeros(100,100); %Creating a matrix for the output.
     
     function res = Udipole2(t,x,y) %Setting up the initial density field.
         res = [-0.5* log(((x - 1)^2 + (y - 1)^2)) + -0.5* log(((x + 1)^2 + (y + 1)^2))]; %This is the equation for it.
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
     for i = 1: length(t) 
         axis([-1 1 -1 1 -3 3]); %axis([xMin xMax yMin yMax]); 
         pause(.1);
         U1 = reshape(concentrationArray(i,:), [100 100]);
         surf(linspace(-2,2),linspace(-2,2),U1,'EdgeColor','none')
     end
     
      xp0 = 0; %Setting initial values
      yp0 = 0;
     
      stateVectorInit = [xp0;yp0]; %The x and y of the particle being tracked.
      
     function outcome = Grady(t, stateVector) %Setting up the grad function so we can take grad of the outcome of divgrad - gradV
        x  = stateVector(1); % Setting up vectors associated with x and y
        y  = stateVector(2); 
        tIndex = int16(t + 1); %Making it so we can index through t later.
        if tIndex > 100; % Making sure things stay in bounds
            tIndex = 100;
        elseif tIndex < 1 
            tIndex = 1;
        end 
        U = concentrationArray(tIndex,:); %Setting up an iterating array
        U = reshape(U, 100, 100); %Converting into a matrix again.
        
        xIndex = int16(((x/4)*100)+50); %Mapping from a (-2,2) coordinate system to a (0, 100) coordinate system.
        yIndex = int16(((y/4)*100)+50);
        
        if xIndex < 1 %Making sure x and y are in bounds
            xIndex = 1; 
        elseif xIndex > 100 
            xIndex = 100;
        end
        
        if yIndex > 100 
            yIndex = 100; 
        elseif yIndex < 1 
            yIndex = 1;
        end 
                
%         gradU = gradient(U); %Setting up an equation that takes the gradient of U (our matrix.)
        arbitrary = -[dx2(xIndex);dy2(yIndex)] + [u(xIndex, yIndex);v(xIndex,yIndex)];  %Adding velocity to -grad.
        dx3 = arbitrary(1); %Formatting things so that dx3 and dy3 outcomes can be put into a vector.
        dy3 = arbitrary(2);
        outcome = [dx3; dy3]; %Making the outcome a vector so it can be processed by ODE45
     end 
    % Linear mapping is when you take something from the range -2 to 2 and
    % put it on the range 1 to 100. It involves scaling. You just use
    % multiplication 
    %/4 * 100 + 50 
    [X, Y] = meshgrid(linspace(-2, 2), linspace(-2, 2)); %Setting up a place for the final calculations to occur. 
    [t1, y1] = ode45(@Grady, [0 100], stateVectorInit); %Perforing ODE45 on the vector.

end 