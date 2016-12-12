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

xMin = 1;
xMax = 10;
yMin = 1;
yMax = 10;
                                     
%time = 1; % Current time (future iterations will be in years from present.)


%% Running code 

     for t = 1:10; 
        F = [0.5* log(((xMin - 1)^2 + yMin^2)/((xMin + 1)^2 + yMin^2))]; %Convert to matrix 
        [t,y] = ode45(del2(F),t,yMin);
        subplot(2,1,1);
        axis([-10 10 -10 10])%axis([xMin xMax yMin yMax]); 
        plot(t, y, '*'); 
        hold on
          
%         subplot(2,1,2); 
%         axis([-10 10 -10 10]);
%         V = [-y; .5*x]; 
%         c = curl(V); 
%         plot(t, c, 'r'); 
%         hold on
    end
            
end 