function trashPatchAnimation1D()
%% For Liv's Sanity 
clf 

%% Variables 
% westPatchShorePollutionRate = 4064.18; %kg/year  
% 
% oceanDebrisWestPollutionRate = 2177.24; %kg/year
% 
% % eastPatchShorePollutionRate = 290.30; %kg/year 
% % 
% % oceanDebrisEastPollutionRate = 2177.24; %kg/year
% 
% %diffusion = 0.005425; %kg/year; 
% 
% westPatch = 14*16329325.33; %Size in kg
% 
% % eastPatch = 16329325.33; %Size in kg 
% 
% currentFromWestToEast = (21444.5*5.25); % Averaged current rates in km/year
%                                       %Converted into kg/year using density
% 
% %currentFromEastToWest = (1576.8*5.25); % Averaged current rates in km/year
%                                      % Converted into kg/year using density
%                                      
% westNormal = 1;
% %eastNormal = 1; 
% a = 1;
% b = 1;
% r = a^2 + b^2 ; 
% 
% 

% xMin = 1;
% xMax = 10;
% yMin = 1;
% yMax = 10;

x = 2; 
y = 2; 

%                                      
%time = 1; % Current time (future iterations will be in years from present.)


%% Running code 

    X = linspace(-2, 2);
    Y = linspace(-2, 2); 
    U0 = zeros(100,100);
    size(U0)
    function res = Udipole(t,x,y)
        res = [0.5* log(((x - 1)^2 + y^2)/((x + 1)^2 + y^2))];
    end
    for i = 1: 100 
       for j = 1:100
        U0(i,j) = Udipole(0, X(i), Y(j));
       end
    end 
    U0 = reshape(U0,[10000,1]); 
    %Convert to matrix
    function divgrad = Divgrad(~, V)
          size(V)
          V = reshape(V,[100,100]);
          [dx, dy] = gradient(V);
          divgrad = divergence(dx,dy);
          divgrad = reshape(divgrad,[10000, 1]);
    end 

    X1 = -2:.1:2;
    Y1 = X1;
    [x,y] = meshgrid(X1);
    u = -y;
    v = .5*x;
    subplot(2,1,2);
    quiver(x,y,u,v)

    [t,y] = ode45(@Divgrad, [0 100], U0);
    subplot(2,1,1);
    for i = 1: length(t) 
        axis([-2 2 -2 2 -5 5]); %axis([xMin xMax yMin yMax]); 
        pause(.5);
        U = reshape(y(i,:), [100 100]);
        az = 180;
        surf(X,Y,U) 
    end 
end